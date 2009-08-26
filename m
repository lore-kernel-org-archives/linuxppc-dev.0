Return-Path: <hal.rosenstock@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0251B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 01:39:20 +1000 (EST)
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220]) by ozlabs.org (Postfix) with ESMTP id 5D238DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 01:39:18 +1000 (EST)
Received: by bwz20 with SMTP id 20so214362bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 08:39:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200908261337.56128.fenkes@de.ibm.com>
References: <200908261337.56128.fenkes@de.ibm.com>
Date: Wed, 26 Aug 2009 11:15:03 -0400
Message-ID: <f0e08f230908260815g70de3002pfd0b34f1b17abd6@mail.gmail.com>
Subject: Re: [ewg] [PATCH] IB/ehca: Construct MAD redirect replies from
	request MAD
From: Hal Rosenstock <hal.rosenstock@gmail.com>
To: Joachim Fenkes <fenkes@de.ibm.com>
Content-Type: multipart/alternative; boundary=0016e65b610e5b93fd04720cea46
Cc: Hal Rosenstock <hnrose@comcast.net>, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e65b610e5b93fd04720cea46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/09, Joachim Fenkes <fenkes@de.ibm.com> wrote:
>
> The old code used a lot of hardcoded values, which might not be valid in
> all
> environments (especially routed fabrics or partitioned subnets). Copy as
> much information as possible from the incoming request to prevent that.
>
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
>
> Hal, Jason -- here's the change I promised. Looks okay to you?
> Roland -- if Hal and Jason don't object, please queue this up for the next
> kernel. Thanks!


Thanks for doing this. It looks sane to me. The only issue I recall that
appears to be remaining is a better setting of ClassPortInfo:RespTimeValue
rather than hardcoding. Perhaps using the value from PortInfo is the way to
go (ideally it would be that value from the port to which the the requester
is being redirected to but that might not be so easy to get from this port
(I guess that could be SA Get PortInfoRecord for that port but that is a
larger change and it likely to be same as local port issuing the redirect
response).

-- Hal

Regards,
> Joachim
>
> drivers/infiniband/hw/ehca/ehca_sqp.c |   47
> ++++++++++++++++++++++++++++----
> 1 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/hw/ehca/ehca_sqp.c
> b/drivers/infiniband/hw/ehca/ehca_sqp.c
> index c568b28..8c1213f 100644
> --- a/drivers/infiniband/hw/ehca/ehca_sqp.c
> +++ b/drivers/infiniband/hw/ehca/ehca_sqp.c
> @@ -125,14 +125,30 @@ struct ib_perf {
>        u8 data[192];
> } __attribute__ ((packed));
>
> +/* TC/SL/FL packed into 32 bits, as in ClassPortInfo */
> +struct tcslfl {
> +       u32 tc:8;
> +       u32 sl:4;
> +       u32 fl:20;
> +} __attribute__ ((packed));
> +
> +/* IP Version/TC/FL packed into 32 bits, as in GRH */
> +struct vertcfl {
> +       u32 ver:4;
> +       u32 tc:8;
> +       u32 fl:20;
> +} __attribute__ ((packed));
>
> static int ehca_process_perf(struct ib_device *ibdev, u8 port_num,
> +                            struct ib_wc *in_wc, struct ib_grh *in_grh,
>                             struct ib_mad *in_mad, struct ib_mad *out_mad)
> {
>        struct ib_perf *in_perf = (struct ib_perf *)in_mad;
>        struct ib_perf *out_perf = (struct ib_perf *)out_mad;
>        struct ib_class_port_info *poi =
>                (struct ib_class_port_info *)out_perf->data;
> +       struct tcslfl *tcslfl =
> +               (struct tcslfl *)&poi->redirect_tcslfl;
>        struct ehca_shca *shca =
>                container_of(ibdev, struct ehca_shca, ib_device);
>        struct ehca_sport *sport = &shca->sport[port_num - 1];
> @@ -158,10 +174,29 @@ static int ehca_process_perf(struct ib_device *ibdev,
> u8 port_num,
>                poi->base_version = 1;
>                poi->class_version = 1;
>                poi->resp_time_value = 18;
> -               poi->redirect_lid = sport->saved_attr.lid;
> -               poi->redirect_qp = sport->pma_qp_nr;
> +
> +               /* copy local routing information from WC where applicable
> */
> +               tcslfl->sl         = in_wc->sl;
> +               poi->redirect_lid  =
> +                       sport->saved_attr.lid | in_wc->dlid_path_bits;
> +               poi->redirect_qp   = sport->pma_qp_nr;
>                poi->redirect_qkey = IB_QP1_QKEY;
> -               poi->redirect_pkey = IB_DEFAULT_PKEY_FULL;
> +
> +               ehca_query_pkey(ibdev, port_num, in_wc->pkey_index,
> +                               &poi->redirect_pkey);
> +
> +               /* if request was globally routed, copy route info */
> +               if (in_grh) {
> +                       struct vertcfl *vertcfl =
> +                               (struct vertcfl
> *)&in_grh->version_tclass_flow;
> +                       memcpy(poi->redirect_gid, in_grh->dgid.raw,
> +                              sizeof(poi->redirect_gid));
> +                       tcslfl->tc        = vertcfl->tc;
> +                       tcslfl->fl        = vertcfl->fl;
> +               } else
> +                       /* else only fill in default GID */
> +                       ehca_query_gid(ibdev, port_num, 0,
> +                                      (union ib_gid *)&poi->redirect_gid);
>
>                ehca_dbg(ibdev, "ehca_pma_lid=%x ehca_pma_qp=%x",
>                         sport->saved_attr.lid, sport->pma_qp_nr);
> @@ -183,8 +218,7 @@ perf_reply:
>
> int ehca_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
>                     struct ib_wc *in_wc, struct ib_grh *in_grh,
> -                    struct ib_mad *in_mad,
> -                    struct ib_mad *out_mad)
> +                    struct ib_mad *in_mad, struct ib_mad *out_mad)
> {
>        int ret;
>
> @@ -196,7 +230,8 @@ int ehca_process_mad(struct ib_device *ibdev, int
> mad_flags, u8 port_num,
>                return IB_MAD_RESULT_SUCCESS;
>
>        ehca_dbg(ibdev, "port_num=%x src_qp=%x", port_num, in_wc->src_qp);
> -       ret = ehca_process_perf(ibdev, port_num, in_mad, out_mad);
> +       ret = ehca_process_perf(ibdev, port_num, in_wc, in_grh,
> +                               in_mad, out_mad);
>
>        return ret;
> }
> --
> 1.6.0.4
>
>
> _______________________________________________
> ewg mailing list
> ewg@lists.openfabrics.org
> http://lists.openfabrics.org/cgi-bin/mailman/listinfo/ewg
>

--0016e65b610e5b93fd04720cea46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGJyPjxicj4KPGRpdj48c3BhbiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIDgvMjYvMDksIDxiIGNs
YXNzPSJnbWFpbF9zZW5kZXJuYW1lIj5Kb2FjaGltIEZlbmtlczwvYj4gJmx0OzxhIGhyZWY9Im1h
aWx0bzpmZW5rZXNAZGUuaWJtLmNvbSI+ZmVua2VzQGRlLmlibS5jb208L2E+Jmd0OyB3cm90ZTo8
L3NwYW4+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9IlBBRERJTkctTEVG
VDogMWV4OyBNQVJHSU46IDBweCAwcHggMHB4IDAuOGV4OyBCT1JERVItTEVGVDogI2NjYyAxcHgg
c29saWQiPlRoZSBvbGQgY29kZSB1c2VkIGEgbG90IG9mIGhhcmRjb2RlZCB2YWx1ZXMsIHdoaWNo
IG1pZ2h0IG5vdCBiZSB2YWxpZCBpbiBhbGw8YnI+ZW52aXJvbm1lbnRzIChlc3BlY2lhbGx5IHJv
dXRlZCBmYWJyaWNzIG9yIHBhcnRpdGlvbmVkIHN1Ym5ldHMpLiBDb3B5IGFzPGJyPgptdWNoIGlu
Zm9ybWF0aW9uIGFzIHBvc3NpYmxlIGZyb20gdGhlIGluY29taW5nIHJlcXVlc3QgdG8gcHJldmVu
dCB0aGF0Ljxicj48YnI+U2lnbmVkLW9mZi1ieTogSm9hY2hpbSBGZW5rZXMgJmx0OzxhIGhyZWY9
Im1haWx0bzpmZW5rZXNAZGUuaWJtLmNvbSI+ZmVua2VzQGRlLmlibS5jb208L2E+Jmd0Ozxicj4t
LS08YnI+PGJyPkhhbCwgSmFzb24gLS0gaGVyZSYjMzk7cyB0aGUgY2hhbmdlIEkgcHJvbWlzZWQu
IExvb2tzIG9rYXkgdG8geW91Pzxicj4KUm9sYW5kIC0tIGlmIEhhbCBhbmQgSmFzb24gZG9uJiMz
OTt0IG9iamVjdCwgcGxlYXNlIHF1ZXVlIHRoaXMgdXAgZm9yIHRoZSBuZXh0PGJyPmtlcm5lbC4g
VGhhbmtzITwvYmxvY2txdW90ZT4KPGRpdj7CoDwvZGl2Pgo8ZGl2PlRoYW5rcyBmb3IgZG9pbmcg
dGhpcy4gSXQgbG9va3Mgc2FuZSB0byBtZS4gVGhlIG9ubHkgaXNzdWUgSSByZWNhbGwgdGhhdCBh
cHBlYXJzIHRvIGJlIHJlbWFpbmluZyBpcyBhIGJldHRlciBzZXR0aW5nIG9mIENsYXNzUG9ydElu
Zm86UmVzcFRpbWVWYWx1ZSByYXRoZXIgdGhhbiBoYXJkY29kaW5nLsKgUGVyaGFwcyB1c2luZyB0
aGUgdmFsdWUgZnJvbSBQb3J0SW5mbyBpcyB0aGUgd2F5IHRvIGdvIChpZGVhbGx5IGl0IHdvdWxk
IGJlIHRoYXQgdmFsdWUgZnJvbSB0aGUgcG9ydCB0byB3aGljaCB0aGUgdGhlIHJlcXVlc3RlciBp
cyBiZWluZyByZWRpcmVjdGVkIHRvIGJ1dCB0aGF0IG1pZ2h0IG5vdCBiZSBzbyBlYXN5IHRvIGdl
dCBmcm9tIHRoaXMgcG9ydCAoSSBndWVzcyB0aGF0IGNvdWxkIGJlIFNBIEdldCBQb3J0SW5mb1Jl
Y29yZCBmb3IgdGhhdCBwb3J0IGJ1dCB0aGF0IGlzIGEgbGFyZ2VyIGNoYW5nZSBhbmQgaXQgbGlr
ZWx5IHRvIGJlIHNhbWUgYXMgbG9jYWwgcG9ydCBpc3N1aW5nIHRoZSByZWRpcmVjdCByZXNwb25z
ZSkuPC9kaXY+Cgo8ZGl2PsKgPC9kaXY+CjxkaXY+LS0gSGFsPC9kaXY+PGJyPgo8YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJQQURESU5HLUxFRlQ6IDFleDsgTUFSR0lOOiAw
cHggMHB4IDBweCAwLjhleDsgQk9SREVSLUxFRlQ6ICNjY2MgMXB4IHNvbGlkIj5SZWdhcmRzLDxi
cj5Kb2FjaGltPGJyPjxicj5kcml2ZXJzL2luZmluaWJhbmQvaHcvZWhjYS9laGNhX3NxcC5jIHzC
oMKgIDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tPGJyPgoxIGZpbGVzIGNoYW5n
ZWQsIDQxIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pPGJyPjxicj5kaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2VoY2EvZWhjYV9zcXAuYyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9ody9laGNhL2VoY2Ffc3FwLmM8YnI+aW5kZXggYzU2OGIyOC4uOGMxMjEzZiAxMDA2NDQ8YnI+
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2VoY2EvZWhjYV9zcXAuYzxicj4KKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL2h3L2VoY2EvZWhjYV9zcXAuYzxicj5AQCAtMTI1LDE0ICsxMjUsMzAg
QEAgc3RydWN0IGliX3BlcmYgezxicj7CoMKgwqDCoMKgwqAgdTggZGF0YVsxOTJdOzxicj59IF9f
YXR0cmlidXRlX18gKChwYWNrZWQpKTs8YnI+PGJyPisvKiBUQy9TTC9GTCBwYWNrZWQgaW50byAz
MiBiaXRzLCBhcyBpbiBDbGFzc1BvcnRJbmZvICovPGJyPitzdHJ1Y3QgdGNzbGZsIHs8YnI+CivC
oMKgwqDCoMKgwqAgdTMyIHRjOjg7PGJyPivCoMKgwqDCoMKgwqAgdTMyIHNsOjQ7PGJyPivCoMKg
wqDCoMKgwqAgdTMyIGZsOjIwOzxicj4rfSBfX2F0dHJpYnV0ZV9fICgocGFja2VkKSk7PGJyPis8
YnI+Ky8qIElQIFZlcnNpb24vVEMvRkwgcGFja2VkIGludG8gMzIgYml0cywgYXMgaW4gR1JIICov
PGJyPitzdHJ1Y3QgdmVydGNmbCB7PGJyPivCoMKgwqDCoMKgwqAgdTMyIHZlcjo0Ozxicj4rwqDC
oMKgwqDCoMKgIHUzMiB0Yzo4Ozxicj4KK8KgwqDCoMKgwqDCoCB1MzIgZmw6MjA7PGJyPit9IF9f
YXR0cmlidXRlX18gKChwYWNrZWQpKTs8YnI+PGJyPnN0YXRpYyBpbnQgZWhjYV9wcm9jZXNzX3Bl
cmYoc3RydWN0IGliX2RldmljZSAqaWJkZXYsIHU4IHBvcnRfbnVtLDxicj4rwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWJfd2Mg
KmluX3djLCBzdHJ1Y3QgaWJfZ3JoICppbl9ncmgsPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGliX21hZCAqaW5fbWFkLCBz
dHJ1Y3QgaWJfbWFkICpvdXRfbWFkKTxicj4Kezxicj7CoMKgwqDCoMKgwqAgc3RydWN0IGliX3Bl
cmYgKmluX3BlcmYgPSAoc3RydWN0IGliX3BlcmYgKilpbl9tYWQ7PGJyPsKgwqDCoMKgwqDCoCBz
dHJ1Y3QgaWJfcGVyZiAqb3V0X3BlcmYgPSAoc3RydWN0IGliX3BlcmYgKilvdXRfbWFkOzxicj7C
oMKgwqDCoMKgwqAgc3RydWN0IGliX2NsYXNzX3BvcnRfaW5mbyAqcG9pID08YnI+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAoc3RydWN0IGliX2NsYXNzX3BvcnRfaW5mbyAqKW91dF9wZXJm
LSZndDtkYXRhOzxicj4KK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgdGNzbGZsICp0Y3NsZmwgPTxicj4r
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoc3RydWN0IHRjc2xmbCAqKSZhbXA7cG9pLSZn
dDtyZWRpcmVjdF90Y3NsZmw7PGJyPsKgwqDCoMKgwqDCoCBzdHJ1Y3QgZWhjYV9zaGNhICpzaGNh
ID08YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250YWluZXJfb2YoaWJkZXYsIHN0
cnVjdCBlaGNhX3NoY2EsIGliX2RldmljZSk7PGJyPsKgwqDCoMKgwqDCoCBzdHJ1Y3QgZWhjYV9z
cG9ydCAqc3BvcnQgPSAmYW1wO3NoY2EtJmd0O3Nwb3J0W3BvcnRfbnVtIC0gMV07PGJyPgpAQCAt
MTU4LDEwICsxNzQsMjkgQEAgc3RhdGljIGludCBlaGNhX3Byb2Nlc3NfcGVyZihzdHJ1Y3QgaWJf
ZGV2aWNlICppYmRldiwgdTggcG9ydF9udW0sPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcG9pLSZndDtiYXNlX3ZlcnNpb24gPSAxOzxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBvaS0mZ3Q7Y2xhc3NfdmVyc2lvbiA9IDE7PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcG9pLSZndDtyZXNwX3RpbWVfdmFsdWUgPSAxODs8YnI+Ci3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHBvaS0mZ3Q7cmVkaXJlY3RfbGlkID0gc3BvcnQtJmd0O3NhdmVkX2F0dHIu
bGlkOzxicj4twqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb2ktJmd0O3JlZGlyZWN0X3Fw
ID0gc3BvcnQtJmd0O3BtYV9xcF9ucjs8YnI+Kzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBjb3B5IGxvY2FsIHJvdXRpbmcgaW5mb3JtYXRpb24gZnJvbSBXQyB3aGVyZSBhcHBs
aWNhYmxlICovPGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjc2xmbC0mZ3Q7c2zC
oMKgwqDCoMKgwqDCoMKgID0gaW5fd2MtJmd0O3NsOzxicj4KK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcG9pLSZndDtyZWRpcmVjdF9saWTCoMKgPTxicj4rwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BvcnQtJmd0O3NhdmVkX2F0dHIubGlkIHwgaW5f
d2MtJmd0O2RsaWRfcGF0aF9iaXRzOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
b2ktJmd0O3JlZGlyZWN0X3FwwqDCoCA9IHNwb3J0LSZndDtwbWFfcXBfbnI7PGJyPsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9pLSZndDtyZWRpcmVjdF9xa2V5ID0gSUJfUVAxX1FLRVk7
PGJyPgotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb2ktJmd0O3JlZGlyZWN0X3BrZXkg
PSBJQl9ERUZBVUxUX1BLRVlfRlVMTDs8YnI+Kzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlaGNhX3F1ZXJ5X3BrZXkoaWJkZXYsIHBvcnRfbnVtLCBpbl93Yy0mZ3Q7cGtleV9pbmRl
eCw8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAmYW1wO3BvaS0mZ3Q7cmVkaXJlY3RfcGtleSk7PGJyPis8YnI+K8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogaWYgcmVxdWVzdCB3YXMgZ2xvYmFsbHkgcm91dGVkLCBj
b3B5IHJvdXRlIGluZm8gKi88YnI+CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChp
bl9ncmgpIHs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCB2ZXJ0Y2ZsICp2ZXJ0Y2ZsID08YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoc3RydWN0IHZlcnRjZmwgKikmYW1w
O2luX2dyaC0mZ3Q7dmVyc2lvbl90Y2xhc3NfZmxvdzs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNweShwb2ktJmd0O3JlZGlyZWN0X2dpZCwgaW5f
Z3JoLSZndDtkZ2lkLnJhdyw8YnI+CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzaXplb2YocG9pLSZndDtyZWRpcmVjdF9naWQpKTs8
YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjc2xmbC0m
Z3Q7dGPCoMKgwqDCoMKgwqDCoMKgPSB2ZXJ0Y2ZsLSZndDt0Yzs8YnI+K8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjc2xmbC0mZ3Q7ZmzCoMKgwqDCoMKgwqDC
oMKgPSB2ZXJ0Y2ZsLSZndDtmbDs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBl
bHNlPGJyPgorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyog
ZWxzZSBvbmx5IGZpbGwgaW4gZGVmYXVsdCBHSUQgKi88YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVoY2FfcXVlcnlfZ2lkKGliZGV2LCBwb3J0X251bSwg
MCw8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAodW5pb24gaWJfZ2lkICopJmFtcDtwb2ktJmd0O3Jl
ZGlyZWN0X2dpZCk7PGJyPjxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVoY2FfZGJn
KGliZGV2LCAmcXVvdDtlaGNhX3BtYV9saWQ9JXggZWhjYV9wbWFfcXA9JXgmcXVvdDssPGJyPgrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcG9ydC0mZ3Q7
c2F2ZWRfYXR0ci5saWQsIHNwb3J0LSZndDtwbWFfcXBfbnIpOzxicj5AQCAtMTgzLDggKzIxOCw3
IEBAIHBlcmZfcmVwbHk6PGJyPjxicj5pbnQgZWhjYV9wcm9jZXNzX21hZChzdHJ1Y3QgaWJfZGV2
aWNlICppYmRldiwgaW50IG1hZF9mbGFncywgdTggcG9ydF9udW0sPGJyPsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWJfd2MgKmluX3djLCBzdHJ1Y3QgaWJf
Z3JoICppbl9ncmgsPGJyPgotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBpYl9tYWQgKmluX21hZCw8YnI+LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgaWJfbWFkICpvdXRfbWFkKTxicj4rwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpYl9tYWQgKmluX21hZCwgc3RydWN0IGliX21h
ZCAqb3V0X21hZCk8YnI+ezxicj7CoMKgwqDCoMKgwqAgaW50IHJldDs8YnI+PGJyPkBAIC0xOTYs
NyArMjMwLDggQEAgaW50IGVoY2FfcHJvY2Vzc19tYWQoc3RydWN0IGliX2RldmljZSAqaWJkZXYs
IGludCBtYWRfZmxhZ3MsIHU4IHBvcnRfbnVtLDxicj4KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gSUJfTUFEX1JFU1VMVF9TVUNDRVNTOzxicj48YnI+wqDCoMKgwqDCoMKgIGVo
Y2FfZGJnKGliZGV2LCAmcXVvdDtwb3J0X251bT0leCBzcmNfcXA9JXgmcXVvdDssIHBvcnRfbnVt
LCBpbl93Yy0mZ3Q7c3JjX3FwKTs8YnI+LcKgwqDCoMKgwqDCoCByZXQgPSBlaGNhX3Byb2Nlc3Nf
cGVyZihpYmRldiwgcG9ydF9udW0sIGluX21hZCwgb3V0X21hZCk7PGJyPivCoMKgwqDCoMKgwqAg
cmV0ID0gZWhjYV9wcm9jZXNzX3BlcmYoaWJkZXYsIHBvcnRfbnVtLCBpbl93YywgaW5fZ3JoLDxi
cj4KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpbl9tYWQsIG91dF9tYWQpOzxicj48YnI+wqDCoMKgwqDCoMKgIHJldHVybiByZXQ7
PGJyPn08YnI+LS08YnI+MS42LjAuNDxicj48YnI+PGJyPl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fPGJyPmV3ZyBtYWlsaW5nIGxpc3Q8YnI+PGEgaHJlZj0i
bWFpbHRvOmV3Z0BsaXN0cy5vcGVuZmFicmljcy5vcmciPmV3Z0BsaXN0cy5vcGVuZmFicmljcy5v
cmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMub3BlbmZhYnJpY3Mub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9ld2ciPmh0dHA6Ly9saXN0cy5vcGVuZmFicmljcy5vcmcvY2dpLWJp
bi9tYWlsbWFuL2xpc3RpbmZvL2V3ZzwvYT48YnI+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K
--0016e65b610e5b93fd04720cea46--
