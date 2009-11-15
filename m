Return-Path: <alonz@discretix.com>
Received: from mail.discretix.com (mail.discretix.com [192.116.217.178])
	by ozlabs.org (Postfix) with SMTP id AB182B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 15 Nov 2009 20:41:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA65D6.53A5B2FF"
Subject: Bug in drivers/serial/of_serial.c?
Date: Sun, 15 Nov 2009 11:30:40 +0200
Message-ID: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
From: "Alon Ziv" <alonz@discretix.com>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA65D6.53A5B2FF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

As of commit eedacbf0, drivers/serial/of_serial.c forces the serial core
to recognize the xps-uart16550-2.00.b as an NS16550 (which had no FIFO).
Prior to this commit, the kernel's auto-configuration logic would
correctly recognize the UART as NS16550A (with 16-byte FIFO).

The following patch corrects the issue in what I believe to be the
correct way:
---
Xilinx 16550 UART is actually 16550A-compatible

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 02406ba..78267af 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -161,7 +161,7 @@ static int of_platform_serial_remove(struct
of_device *ofdev)
 static struct of_device_id __devinitdata of_platform_serial_table[] =3D =
{
 	{ .type =3D "serial", .compatible =3D "ns8250",   .data =3D (void
*)PORT_8250, },
 	{ .type =3D "serial", .compatible =3D "ns16450",  .data =3D (void
*)PORT_16450, },
-	{ .type =3D "serial", .compatible =3D "ns16550",  .data =3D (void
*)PORT_16550, },
+	{ .type =3D "serial", .compatible =3D "ns16550",  .data =3D (void
*)PORT_16550A, },
 	{ .type =3D "serial", .compatible =3D "ns16750",  .data =3D (void
*)PORT_16750, },
 	{ .type =3D "serial", .compatible =3D "ns16850",  .data =3D (void
*)PORT_16850, },
 #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
*************************************************************************=
*********************
IMPORTANT: The contents of this email and any attachments are confidentia=
l. They are intended for the=20
named recipient(s) only.
If you have received this email in error, please notify the system manage=
r or the sender immediately and do=20
not disclose the contents to anyone or make copies thereof.

------_=_NextPart_001_01CA65D6.53A5B2FF
Content-Type: application/octet-stream;
	name="03-of_serial-16550A.patch"
Content-Transfer-Encoding: base64
Content-Description: 03-of_serial-16550A.patch
Content-Disposition: attachment;
	filename="03-of_serial-16550A.patch"

Y29tbWl0IDc5MTE5Y2Y4MDBjNTFmNDNmN2Y1NDE1MjUwYjk5NjY0YmM1NzY0MWQKQXV0aG9yOiBB
bG9uIFppdiA8YWxvbnpAZGlzY3JldGl4LmNvbT4KRGF0ZTogICBTdW4gTm92IDE1IDA5OjQ1OjA0
IDIwMDkgKzAyMDAKCiAgICBYaWxpbnggMTY1NTAgVUFSVCBpcyBhY3R1YWxseSAxNjU1MEEtY29t
cGF0aWJsZQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2VyaWFsL29mX3NlcmlhbC5jIGIvZHJpdmVy
cy9zZXJpYWwvb2Zfc2VyaWFsLmMKaW5kZXggMDI0MDZiYS4uNzgyNjdhZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9zZXJpYWwvb2Zfc2VyaWFsLmMKKysrIGIvZHJpdmVycy9zZXJpYWwvb2Zfc2VyaWFs
LmMKQEAgLTE2MSw3ICsxNjEsNyBAQCBzdGF0aWMgaW50IG9mX3BsYXRmb3JtX3NlcmlhbF9yZW1v
dmUoc3RydWN0IG9mX2RldmljZSAqb2ZkZXYpCiBzdGF0aWMgc3RydWN0IG9mX2RldmljZV9pZCBf
X2RldmluaXRkYXRhIG9mX3BsYXRmb3JtX3NlcmlhbF90YWJsZVtdID0gewogCXsgLnR5cGUgPSAi
c2VyaWFsIiwgLmNvbXBhdGlibGUgPSAibnM4MjUwIiwgICAuZGF0YSA9ICh2b2lkICopUE9SVF84
MjUwLCB9LAogCXsgLnR5cGUgPSAic2VyaWFsIiwgLmNvbXBhdGlibGUgPSAibnMxNjQ1MCIsICAu
ZGF0YSA9ICh2b2lkICopUE9SVF8xNjQ1MCwgfSwKLQl7IC50eXBlID0gInNlcmlhbCIsIC5jb21w
YXRpYmxlID0gIm5zMTY1NTAiLCAgLmRhdGEgPSAodm9pZCAqKVBPUlRfMTY1NTAsIH0sCisJeyAu
dHlwZSA9ICJzZXJpYWwiLCAuY29tcGF0aWJsZSA9ICJuczE2NTUwIiwgIC5kYXRhID0gKHZvaWQg
KilQT1JUXzE2NTUwQSwgfSwKIAl7IC50eXBlID0gInNlcmlhbCIsIC5jb21wYXRpYmxlID0gIm5z
MTY3NTAiLCAgLmRhdGEgPSAodm9pZCAqKVBPUlRfMTY3NTAsIH0sCiAJeyAudHlwZSA9ICJzZXJp
YWwiLCAuY29tcGF0aWJsZSA9ICJuczE2ODUwIiwgIC5kYXRhID0gKHZvaWQgKilQT1JUXzE2ODUw
LCB9LAogI2lmZGVmIENPTkZJR19TRVJJQUxfT0ZfUExBVEZPUk1fTldQU0VSSUFMCg==

------_=_NextPart_001_01CA65D6.53A5B2FF--
