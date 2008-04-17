Return-Path: <luoxu_gun@yahoo.com.cn>
Received: from web15915.mail.cnb.yahoo.com (web15915.mail.cnb.yahoo.com
	[202.165.102.224]) by ozlabs.org (Postfix) with SMTP id CD14BDE336
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:51:24 +1000 (EST)
Date: Fri, 18 Apr 2008 00:44:43 +0800 (CST)
From: =?gb2312?q?=D0=F1=20=C2=DE?= <luoxu_gun@yahoo.com.cn>
Subject: =?gb2312?q?=BB=D8=B8=B4=A3=BA=20RE:=20A=20question=20about=20the=208250/1?=
	=?gb2312?q?6550=20Driver?=
To: Li Yang <LeoLi@freescale.com>, Linu PPC Mail list <linuxppc-dev@ozlabs.org>
In-Reply-To: <989B956029373F45A0B8AF02970818900200759C@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1261761823-1208450683=:72220"
Message-ID: <58063.72220.qm@web15915.mail.cnb.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1261761823-1208450683=:72220
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello Leo:
    Follow your advises, i look the source code and find that you are right. In the source code, There are 2 functions can do some work for the serial port initralization. The code is followed.
1. static int __devinit serial8250_probe(struct platform_device *dev)
2. static void __init serial8250_isa_init_ports(void)

In my system i use the function 2 and this function should use the structer old_serial_port. 
In fact the function 1 can initralize the serial port too. But i don't known how to call this function. 

For the more, i have find some source code in of_serial.c which is in the \drivers\serial directory. In this file, the function 
static int __devinit of_platform_serial_probe(struct of_device *ofdev,
                        const struct of_device_id *id)
call the serial8250_register_port function to initralized the serial port.

This issues makes me puzzlled, Could you help me to analyzed it? and what kind of the function i should used to initralize my serial port.



thanks 
best wishs

Li Yang <LeoLi@freescale.com> –¥µ¿£∫ > -----Original Message-----
> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org 
> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] 
> On Behalf Of –Ò ¬ﬁ
> Sent: Thursday, April 17, 2008 3:32 PM
> To: Linu PPC Mail list
> Cc: Wood Scott
> Subject: A question about the 8250/16550 Driver
> 
> Hello:
>     I have founded that the serial can't be initialized as 
> the bootting process. My platform is MPC8313 and my kernel 
> version is linux-2.6.23.9. I look though the source code and 
> find that the MPC8313 driver is compatible with 8250/16550. 
> The driver is in the \drivers\serial\8250.c
> 
> In the function serial8250_isa_init_ports we should use the 
> structer old_serial_port  but i can't find the definition for 
> this struct. I can only find the following senrense in the 
> head of this file 

If you look into the function carefully enough, you can find that old_serial_port is optional and can be empty.  It seems to be some leftover to provide backward compatibility when the port structure changed.

- Leo


       
---------------------------------
 —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°
--0-1261761823-1208450683=:72220
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello Leo:<br>&nbsp;&nbsp;&nbsp; Follow your advises, i look the source code and find that you are right. In the source code, There are 2 functions can do some work for the serial port initralization. The code is followed.<br>1. static int __devinit serial8250_probe(struct platform_device *dev)<br>2. static void __init serial8250_isa_init_ports(void)<br><br>In my system i use the function 2 and this function should use the structer old_serial_port. <br>In fact the function 1 can initralize the serial port too. But i don't known how to call this function. <br><br>For the more, i have find some source code in of_serial.c which is in the \drivers\serial directory. In this file, the function <br>static int __devinit of_platform_serial_probe(struct of_device *ofdev,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; const struct of_device_id *id)<br>call the serial8250_register_port function to initralized the
 serial port.<br><br>This issues makes me puzzlled, Could you help me to analyzed it? and what kind of the function i should used to initralize my serial port.<br><br><br><br>thanks <br>best wishs<br><br><b><i>Li Yang &lt;LeoLi@freescale.com&gt;</i></b> –¥µ¿£∫<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> &gt; -----Original Message-----<br>&gt; From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org <br>&gt; [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] <br>&gt; On Behalf Of –Ò ¬ﬁ<br>&gt; Sent: Thursday, April 17, 2008 3:32 PM<br>&gt; To: Linu PPC Mail list<br>&gt; Cc: Wood Scott<br>&gt; Subject: A question about the 8250/16550 Driver<br>&gt; <br>&gt; Hello:<br>&gt;     I have founded that the serial can't be initialized as <br>&gt; the bootting process. My platform is MPC8313 and my kernel <br>&gt; version is linux-2.6.23.9. I look though the source code and <br>&gt; find that the MPC8313
 driver is compatible with 8250/16550. <br>&gt; The driver is in the \drivers\serial\8250.c<br>&gt; <br>&gt; In the function serial8250_isa_init_ports we should use the <br>&gt; structer old_serial_port  but i can't find the definition for <br>&gt; this struct. I can only find the following senrense in the <br>&gt; head of this file <br><br>If you look into the function carefully enough, you can find that old_serial_port is optional and can be empty.  It seems to be some leftover to provide backward compatibility when the port structure changed.<br><br>- Leo<br></blockquote><br><p>&#32;


      <hr size=1><a href="http://cn.mail.yahoo.com/"> —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°</a>
--0-1261761823-1208450683=:72220--
