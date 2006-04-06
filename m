Return-Path: <avolkov@varma-el.com>
Date: Thu, 6 Apr 2006 18:21:44 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <583603349.20060406182144@varma-el.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: MPC5200 + LocalPlus Bus + memcpy
In-Reply-To: <20060405113825.GA9110@localhost.localdomain>
References: <20060405113825.GA9110@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------5B121F43C468BED"
Cc: Sylvain Munaut <tnt@246tNt.com>, Paul Mackerras <paulus@samba.org>,
	Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Reply-To: Andrey Volkov <avolkov@varma-el.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------------5B121F43C468BED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Sascha.

On Wednesday, April 5, 2006, Sascha Hauer wrote:

> Hi all,

> I try to use jffs2 on a flash device connected to the mpc5200
> LocalPlus Bus. This bus does not allow misaligned accesses.
> The jffs2 code uses memcpy to copy from a word aligned address to an
> odd address. The ppc memcpy implementation first copies three bytes to get
> the target address word aligned, but then the source address is on an
> odd address. The following word accesses on this unaligned address fail
> badly.
Invalid crc on 'name' field ;)?

> I have fixed my problem by modifying the physmap mtd driver, but some
> day someone wants to connect SRAM to the LocalPlus Bus and I guess he
> will expect memcpy to work.
Heh, I'll have same problem. Patch (dirty hack)
attached (vs head of vanilla 2.6. tree)

> (BTW the arm implementation of memcpy seems to work around this problem)
Wrong, memcpy to/from SDRAM _may_ be unaligned, only
memcpy_fromio/memcpy_toio _must_ be aligned to even addresses.

P.S.
Paul, Sylvain, any suggestions to fix it?
AFAIK, memcpy_to/from_io must be it string.s, isn't it?

P.P.S Sacha if you start to write mscan driver, then please wait a
week, I planned to send my work to can-socket at next Friday.

-- 
Regards,
Andrey Volkov
------------5B121F43C468BED
Content-Type: application/octet-stream; name="mpc52xx_LPB_jffs2_hack.diff"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="mpc52xx_LPB_jffs2_hack.diff"

ZGlmZiAtLWdpdCBhL2ZzL2pmZnMyL3NjYW4uYyBiL2ZzL2pmZnMyL3NjYW4uYwppbmRleCBj
ZjU1YjIyLi4zYmY2MWQ2IDEwMDY0NAotLS0gYS9mcy9qZmZzMi9zY2FuLmMKKysrIGIvZnMv
amZmczIvc2Nhbi5jCkBAIC04MzEsNyArODMxLDcgQEAgc3RhdGljIGludCBqZmZzMl9zY2Fu
X2RpcmVudF9ub2RlKHN0cnVjdAogCWlmICghZmQpIHsKIAkJcmV0dXJuIC1FTk9NRU07CiAJ
fQotCW1lbWNweSgmZmQtPm5hbWUsIHJkLT5uYW1lLCByZC0+bnNpemUpOworCW1lbWNweV9m
cm9taW8oJmZkLT5uYW1lLCByZC0+bmFtZSwgcmQtPm5zaXplKTsKIAlmZC0+bmFtZVtyZC0+
bnNpemVdID0gMDsKIAogCWNyYyA9IGNyYzMyKDAsIGZkLT5uYW1lLCByZC0+bnNpemUpOwpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tcHBjL2lvLmggYi9pbmNsdWRlL2FzbS1wcGMvaW8u
aAppbmRleCBiOTE5ZDhmLi5jMmYxNzNhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1wcGMv
aW8uaAorKysgYi9pbmNsdWRlL2FzbS1wcGMvaW8uaApAQCAtMzU0LDYgKzM1NCwyOSBAQCBl
eHRlcm4gdm9pZCBfb3V0c2xfbnModm9sYXRpbGUgdTMyIF9faW9tCiAjZGVmaW5lIG1lbXNl
dF9pbyhhLGIsYykgICAgICAgbWVtc2V0KCh2b2lkICopKGEpLChiKSwoYykpCiAjZGVmaW5l
IG1lbWNweV9mcm9taW8oYSxiLGMpICAgbWVtY3B5KChhKSwodm9pZCAqKShiKSwoYykpCiAj
ZGVmaW5lIG1lbWNweV90b2lvKGEsYixjKSAgICAgbWVtY3B5KCh2b2lkICopKGEpLChiKSwo
YykpCisjZWxpZiBkZWZpbmVkIChDT05GSUdfUFBDX01QQzUyeHgpCitzdGF0aWMgaW5saW5l
IHZvaWQgbWVtc2V0X2lvKHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkciwgdW5zaWduZWQg
Y2hhciB2YWwsIGludCBjb3VudCkKK3sKKwl2b2xhdGlsZSB1OCBfX2lvbWVtICphZGRyX3U4
ID0gYWRkcjsKKwlmb3IoO2NvdW50PjA7Y291bnQtLSkKKwkJKmFkZHJfdTgrKyA9IHZhbDsK
K30KKworc3RhdGljIGlubGluZSB2b2lkIG1lbWNweV9mcm9taW8odm9pZCAqZHN0LGNvbnN0
IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqc3JjLCBpbnQgY291bnQpCit7CisJY29uc3Qgdm9s
YXRpbGUgdTggX19pb21lbSAqc3JjX3U4ID0gc3JjOworCXU4ICpkc3RfdTggPSBkc3Q7CisJ
Zm9yKDtjb3VudD4wO2NvdW50LS0pCisJCSpkc3RfdTgrKyA9ICpzcmNfdTgrKzsKK30KKwor
c3RhdGljIGlubGluZSB2b2lkIG1lbWNweV90b2lvKHZvbGF0aWxlIHZvaWQgX19pb21lbSAq
ZHN0LCBjb25zdCB2b2lkICpzcmMsIGludCBjb3VudCkKK3sKKwljb25zdCB1OCAqc3JjX3U4
ID0gc3JjOworCXZvbGF0aWxlIHU4IF9faW9tZW0gKmRzdF91OCA9IGRzdDsKKwlmb3IoO2Nv
dW50PjA7Y291bnQtLSkKKwkJKmRzdF91OCsrID0gKnNyY191OCsrOworfQogI2Vsc2UKIHN0
YXRpYyBpbmxpbmUgdm9pZCBtZW1zZXRfaW8odm9sYXRpbGUgdm9pZCBfX2lvbWVtICphZGRy
LCB1bnNpZ25lZCBjaGFyIHZhbCwgaW50IGNvdW50KQogewo=
------------5B121F43C468BED--
