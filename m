Message-ID: <3FC0C6D9.8020203@imc-berlin.de>
Date: Sun, 23 Nov 2003 15:40:25 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: oops in i2c-rpx.c !
Content-Type: multipart/mixed;
 boundary="------------050005090406040003030004"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------050005090406040003030004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi there,

the attached trival patch fixes a problem when using i2c-rpx.c without applying
the "microcode relocation patch".

Thanks.

BTW: Why is this driver not in linuxppc-2.4 but in linuxppc_2_4_devel?

--
Steven Scholz

imc Measurement & Control               imc Meßsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
fon: +49 30 467090-0                    Tel: 030 / 467090-0
fax: +49 30 4631576                     fax: 030 / 4631576


--------------050005090406040003030004
Content-Type: text/plain;
 name="i2c-rpx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-rpx.patch"

Index: drivers/i2c/i2c-rpx.c
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/drivers/i2c/i2c-rpx.c,v
retrieving revision 1.2
diff -u -r1.2 i2c-rpx.c
--- drivers/i2c/i2c-rpx.c	2003/10/30 00:32:55	1.2
+++ drivers/i2c/i2c-rpx.c	2003/11/23 14:37:11
@@ -35,10 +35,12 @@

 	data->iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];

+#ifdef USE_IIC_PATCH
 	/* Check for and use a microcode relocation patch.
 	*/
 	if ((data->reloc = data->iip->iic_rpbase))
 		data->iip = (iic_t *)&cp->cp_dpmem[data->iip->iic_rpbase];
+#endif

 	data->i2c = (i2c8xx_t *)&(immap->im_i2c);
 	data->cp = cp;

--------------050005090406040003030004--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
