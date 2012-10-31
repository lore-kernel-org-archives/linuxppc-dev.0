Return-Path: <sachin.surendran@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 052122C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 14:01:10 +1100 (EST)
Received: by mail-vb0-f51.google.com with SMTP id fn1so1008627vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2012 20:01:07 -0700 (PDT)
MIME-Version: 1.0
From: sachin surendran <sachin.surendran@gmail.com>
Date: Wed, 31 Oct 2012 16:00:26 +1300
Message-ID: <CABCb4NUJ0uJA5Z9vdgLndvpLrnK=m5xaeiHZxAwHKFU2DroaFw@mail.gmail.com>
Subject: [PATCH] i2c-cpm: Fix to takeback i2c bus master-ship after a collision
To: linuxppc-dev@lists.ozlabs.org, jochen@scram.de
Content-Type: multipart/alternative; boundary=14dae9cdc6c12a6cff04cd521d04
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--14dae9cdc6c12a6cff04cd521d04
Content-Type: text/plain; charset=ISO-8859-1

In case of collision on i2c bus the controller which lost bus mastership
stays as a slave
for all subsequent transfers. This results in the i2c controller never
writing to the bus
for future transactions, resulting in i2c transfer timeouts.
  This fix checks for a collision on last I2C transaction and sets the
I2COM_MASTER
bit for the new transaction.

Signed-off-by: Sachin Surendran <sachin.surendran@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-cpm.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index c1e1096..bb94c6d 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -338,6 +338,14 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap,
struct i2c_msg *msgs, int num)
        tptr = 0;
        rptr = 0;

+       /*
+        * If there was a collision in the last i2c transaction,
+        * Set I2COM_MASTER as it was cleared during collision.
+        */
+       if (in_be16(&tbdf->cbd_sc) & BD_SC_CL) {
+               out_8(&cpm->i2c_reg->i2com, I2COM_MASTER);
+       }
+
        while (tptr < num) {
                pmsg = &msgs[tptr];
                dev_dbg(&adap->dev, "R: %d T: %d\n", rptr, tptr);

--14dae9cdc6c12a6cff04cd521d04
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

In case of collision on i2c bus the controller which lost bus mastership st=
ays as a slave<div>for all subsequent transfers. This results in the i2c co=
ntroller never writing to the bus=A0</div><div>for future transactions, res=
ulting in i2c transfer timeouts.</div>

<div>=A0 This fix checks for a collision on last I2C transaction and sets=
=A0the I2COM_MASTER=A0</div><div>bit for=A0the new transaction.</div><div><=
div><div><br></div><div>Signed-off-by: Sachin Surendran &lt;<a href=3D"mail=
to:sachin.surendran@alliedtelesis.co.nz">sachin.surendran@alliedtelesis.co.=
nz</a>&gt;<br>

</div><div>---</div><div><div><div><div>=A0drivers/i2c/busses/i2c-cpm.c | =
=A0 =A08 ++++++++</div><div>=A01 file changed, 8 insertions(+)</div><div><b=
r></div><div>diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses=
/i2c-cpm.c</div>

<div>index c1e1096..bb94c6d 100644</div><div>--- a/drivers/i2c/busses/i2c-c=
pm.c</div><div>+++ b/drivers/i2c/busses/i2c-cpm.c</div><div>@@ -338,6 +338,=
14 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msg=
s, int num)</div>

<div>=A0 =A0 =A0 =A0 tptr =3D 0;</div><div>=A0 =A0 =A0 =A0 rptr =3D 0;</div=
><div>=A0</div><div>+ =A0 =A0 =A0 /*</div><div>+ =A0 =A0 =A0 =A0* If there =
was a collision in the last i2c transaction,</div><div>+ =A0 =A0 =A0 =A0* S=
et I2COM_MASTER as it was cleared during collision.</div>

<div>+ =A0 =A0 =A0 =A0*/</div><div>+ =A0 =A0 =A0 if (in_be16(&amp;tbdf-&gt;=
cbd_sc) &amp; BD_SC_CL) {</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&am=
p;cpm-&gt;i2c_reg-&gt;i2com, I2COM_MASTER);</div><div>+ =A0 =A0 =A0 }</div>=
<div>+</div><div>=A0 =A0 =A0 =A0 while (tptr &lt; num) {</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmsg =3D &amp;msgs[tptr];</div><div>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&amp;adap-&gt;dev, &quot;R: %d T: %=
d\n&quot;, rptr, tptr);</div></div></div></div><div><br></div>
</div></div>

--14dae9cdc6c12a6cff04cd521d04--
