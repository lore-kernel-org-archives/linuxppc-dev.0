Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 71E42B7D2E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 15:46:32 +1100 (EST)
Received: by ywh33 with SMTP id 33so5414404ywh.11
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Mar 2010 20:46:30 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Mar 2010 21:46:10 -0700
Message-ID: <fa686aa41003092046m725c8376x64958366b715187@mail.gmail.com>
Subject: Re: [PATCH] Macintosh: fix brace and trailing statement coding style
	issues in adb-iop.c This is a patch to the adb-iop.c file that cleans
	up
	brace and trailing statement warnings found by the checkpatch.pl tool.
	Signed-off-by: Michael Beardsworth <m
To: Michael Beardsworth <mbeards2@uoregon.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.or,
	Michael Beardsworth <mbeards@mbeards-mbp.lulzzzzzzz.info>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks for the patch.  However, whitespace changes like this usually
aren't worth bothering with.  Yeah, sure, they are technically
violations to the coding style, but they aren't egregious and aren't a
serious impediment to readability.  In general I don't want to see
purely minor coding style cleanup patches unless they are part of a
larger effort to tighten up and fix bugs in a driver.  Otherwise it is
just churn for little or no return on effort.

A good place to go looking for really bad code that needs cleaning
effort is in the staging/ directory.

Cheers,
g.

On Tue, Mar 9, 2010 at 2:46 PM, Michael Beardsworth
<mbeards2@uoregon.edu> wrote:
> From: Michael Beardsworth <mbeards@mbeards-mbp.lulzzzzzzz.info>
>
> ---
> =A0drivers/macintosh/adb-iop.c | =A0 41 +++++++++++++++++++++++----------=
--------
> =A01 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
> index 4446966..e813589 100644
> --- a/drivers/macintosh/adb-iop.c
> +++ b/drivers/macintosh/adb-iop.c
> @@ -19,13 +19,13 @@
> =A0#include <linux/init.h>
> =A0#include <linux/proc_fs.h>
>
> -#include <asm/macintosh.h>
> -#include <asm/macints.h>
> +#include <asm/macintosh.h>
> +#include <asm/macints.h>
> =A0#include <asm/mac_iop.h>
> =A0#include <asm/mac_oss.h>
> =A0#include <asm/adb_iop.h>
>
> -#include <linux/adb.h>
> +#include <linux/adb.h>
>
> =A0/*#define DEBUG_ADB_IOP*/
>
> @@ -67,7 +67,8 @@ static void adb_iop_end_req(struct adb_request *req, in=
t state)
> =A0{
> =A0 =A0 =A0 =A0req->complete =3D 1;
> =A0 =A0 =A0 =A0current_req =3D req->next;
> - =A0 =A0 =A0 if (req->done) (*req->done)(req);
> + =A0 =A0 =A0 if (req->done)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*req->done)(req);
> =A0 =A0 =A0 =A0adb_iop_state =3D state;
> =A0}
>
> @@ -85,9 +86,8 @@ static void adb_iop_complete(struct iop_msg *msg)
> =A0 =A0 =A0 =A0local_irq_save(flags);
>
> =A0 =A0 =A0 =A0req =3D current_req;
> - =A0 =A0 =A0 if ((adb_iop_state =3D=3D sending) && req && req->reply_exp=
ected) {
> + =A0 =A0 =A0 if ((adb_iop_state =3D=3D sending) && req && req->reply_exp=
ected)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0adb_iop_state =3D awaiting_reply;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0local_irq_restore(flags);
> =A0}
> @@ -113,8 +113,8 @@ static void adb_iop_listen(struct iop_msg *msg)
> =A0 =A0 =A0 =A0req =3D current_req;
>
> =A0#ifdef DEBUG_ADB_IOP
> - =A0 =A0 =A0 printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X=
", req,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uint) amsg->count + 2, (uint) amsg->flags,=
 (uint) amsg->cmd);
> + =A0 =A0 =A0 printk(KERN_WARNING "adb_iop_listen %p: rcvd packet, %d byt=
es: %02X %02X",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req, (uint) amsg->count + 2, (uint) amsg->f=
lags, (uint) amsg->cmd);
> =A0 =A0 =A0 =A0for (i =3D 0; i < amsg->count; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(" %02X", (uint) amsg->data[i]);
> =A0 =A0 =A0 =A0printk("\n");
> @@ -130,9 +130,8 @@ static void adb_iop_listen(struct iop_msg *msg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg->reply[0] =3D ADB_IOP_TIMEOUT | ADB_IO=
P_AUTOPOLL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg->reply[1] =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg->reply[2] =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req && (adb_iop_state !=3D idle)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req && (adb_iop_state !=3D idle))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0adb_iop_end_req(req, idle)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* TODO: is it possible for more than one =
chunk of data =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =A0 =A0 =A0 to arrive before the timeou=
t? If so we need to */
> @@ -169,12 +168,13 @@ static void adb_iop_start(void)
>
> =A0 =A0 =A0 =A0/* get the packet to send */
> =A0 =A0 =A0 =A0req =3D current_req;
> - =A0 =A0 =A0 if (!req) return;
> + =A0 =A0 =A0 if (!req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 =A0 =A0 =A0local_irq_save(flags);
>
> =A0#ifdef DEBUG_ADB_IOP
> - =A0 =A0 =A0 printk("adb_iop_start %p: sending packet, %d bytes:", req, =
req->nbytes);
> + =A0 =A0 =A0 printk(KERN_WARNING "adb_iop_start %p: sending packet, %d b=
ytes:", req, req->nbytes);
> =A0 =A0 =A0 =A0for (i =3D 0 ; i < req->nbytes ; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(" %02X", (uint) req->data[i]);
> =A0 =A0 =A0 =A0printk("\n");
> @@ -203,13 +203,14 @@ static void adb_iop_start(void)
>
> =A0int adb_iop_probe(void)
> =A0{
> - =A0 =A0 =A0 if (!iop_ism_present) return -ENODEV;
> + =A0 =A0 =A0 if (!iop_ism_present)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0int adb_iop_init(void)
> =A0{
> - =A0 =A0 =A0 printk("adb: IOP ISM driver v0.4 for Unified ADB.\n");
> + =A0 =A0 =A0 printk(KERN_MESSAGE "adb: IOP ISM driver v0.4 for Unified A=
DB.\n");
> =A0 =A0 =A0 =A0iop_listen(ADB_IOP, ADB_CHAN, adb_iop_listen, "ADB");
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -219,10 +220,12 @@ int adb_iop_send_request(struct adb_request *req, i=
nt sync)
> =A0 =A0 =A0 =A0int err;
>
> =A0 =A0 =A0 =A0err =3D adb_iop_write(req);
> - =A0 =A0 =A0 if (err) return err;
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>
> =A0 =A0 =A0 =A0if (sync) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!req->complete) adb_iop_poll();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!req->complete)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adb_iop_poll();
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -252,7 +255,8 @@ static int adb_iop_write(struct adb_request *req)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0local_irq_restore(flags);
> - =A0 =A0 =A0 if (adb_iop_state =3D=3D idle) adb_iop_start();
> + =A0 =A0 =A0 if (adb_iop_state =3D=3D idle)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adb_iop_start();
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -264,7 +268,8 @@ int adb_iop_autopoll(int devs)
>
> =A0void adb_iop_poll(void)
> =A0{
> - =A0 =A0 =A0 if (adb_iop_state =3D=3D idle) adb_iop_start();
> + =A0 =A0 =A0 if (adb_iop_state =3D=3D idle)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adb_iop_start();
> =A0 =A0 =A0 =A0iop_ism_irq(0, (void *) ADB_IOP);
> =A0}
>
> --
> 1.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
