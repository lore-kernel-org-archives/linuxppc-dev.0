Return-Path: <srs0=h86y=3b=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqcpS4r4dzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 09:02:08 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vqcpS31swz8tBf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 09:02:08 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vqcpR06GBz9s76
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2017 09:02:06 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2OLwgnY081334
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 18:02:04 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29d74mb0ng-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 18:02:04 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 16:02:03 -0600
Date: Fri, 24 Mar 2017 15:01:49 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <michael.neuling@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v3 06/10] VAS: Define helpers to alloc/free windows
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-7-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490345959.28113.67.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490345959.28113.67.camel@au1.ibm.com>
Message-Id: <20170324220149.GF8330@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [michael.neuling@au1.ibm.com] wrote:
> On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> > Define helpers to allocate/free VAS window objects. These will
> > be used in follow-on patches when opening/closing windows.
> >=20
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > ---
> > =A0drivers/misc/vas/vas-window.c | 74 +++++++++++++++++++++++++++++++++=
++++++++-
> > -
> > =A01 file changed, 72 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-windo=
w.c
> > index edf5c9f..9233bf5 100644
> > --- a/drivers/misc/vas/vas-window.c
> > +++ b/drivers/misc/vas/vas-window.c
> > @@ -119,7 +119,7 @@ static void unmap_wc_mmio_bars(struct vas_window *w=
indow)
> > =A0 * OS/User Window Context (UWC) MMIO Base Address Region for the giv=
en
> > window.
> > =A0 * Map these bus addresses and save the mapped kernel addresses in @=
window.
> > =A0 */
> > -int map_wc_mmio_bars(struct vas_window *window)
> > +static int map_wc_mmio_bars(struct vas_window *window)
> > =A0{
> > =A0	int len;
> > =A0	uint64_t start;
> > @@ -472,8 +472,78 @@ int init_winctx_regs(struct vas_window *window, st=
ruct
> > vas_winctx *winctx)
> > =A0	return 0;
> > =A0}
> > =A0
> > -/* stub for now */
> > +DEFINE_SPINLOCK(vas_ida_lock);
> > +
> > +void vas_release_window_id(struct ida *ida, int winid)
> > +{
> > +	spin_lock(&vas_ida_lock);
> > +	ida_remove(ida, winid);
> > +	spin_unlock(&vas_ida_lock);
> > +}
> > +
> > +int vas_assign_window_id(struct ida *ida)
> > +{
> > +	int rc, winid;
> > +
> > +	rc =3D ida_pre_get(ida, GFP_KERNEL);
> > +	if (!rc)
> > +		return -EAGAIN;
> > +
> > +	spin_lock(&vas_ida_lock);
> > +	rc =3D ida_get_new_above(ida, 0, &winid);
> > +	spin_unlock(&vas_ida_lock);
> > +
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (winid > VAS_MAX_WINDOWS_PER_CHIP) {
> > +		pr_err("VAS: Too many (%d) open windows\n", winid);
> > +		vas_release_window_id(ida, winid);
> > +		return -EAGAIN;
> > +	}
> > +
> > +	return winid;
> > +}
> > +
> > +static void vas_window_free(struct vas_window *window)
> > +{
> > +	unmap_wc_mmio_bars(window);
> > +	kfree(window->paste_addr_name);
> > +	kfree(window);
> > +}
> > +
> > +static struct vas_window *vas_window_alloc(struct vas_instance *vinst,=
 int
> > id)
> > +{
> > +	struct vas_window *window;
> > +
> > +	window =3D kzalloc(sizeof(*window), GFP_KERNEL);
> > +	if (!window)
> > +		return NULL;
> > +
> > +	window->vinst =3D vinst;
> > +	window->winid =3D id;
> > +
> > +	if (map_wc_mmio_bars(window))
> > +		goto out_free;
> > +
> > +	return window;
> > +
> > +out_free:
> > +	kfree(window);
> > +	return NULL;
> > +}
> > +
> > =A0int vas_window_reset(struct vas_instance *vinst, int winid)
> >=20
>=20
> This interface seems a little weird to me. Needing an alloc in a hardware=
 reset
> path seems a bit strange.

Yeah, the name alloc in this interface is awkward.

I probably can drop this interface. Its used only during start up to clear
the window contexts. But since we must and do clear each window context
before using, we don't to do this during start up.

>=20
> Maybe the data structures are the issue.  A window is a hardware construc=
t.=20
> Something that uses it should probably be called something else like a co=
ntext.=20
> Something that references a window should just be the vas_instance + wini=
d.=20
>=20
> You should be able to reset this hardware window by referencing structures
> already allocated.  Something associated with the struct vas_instance.
>=20

'struct vas_winctx' is the window context (register fields associated
with the window) 'struct vas_window' is a container for the kernel state
associated with a window.

> Mikey

Thanks for the review.

Sukadev
