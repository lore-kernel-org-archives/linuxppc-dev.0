Return-Path: <silicom@163.com>
Received: from m13-130.163.com (m13-130.163.com [220.181.13.130])
	by ozlabs.org (Postfix) with SMTP id A9C46DDF15
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jul 2007 12:34:47 +1000 (EST)
Date: Sun, 1 Jul 2007 10:03:41 +0800 (CST)
From: silicom <silicom@163.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <1719162188.1761901183255421508.JavaMail.coremail@bj163app130.163.com>
Subject: Can anyone send me a copy of ac97 driver with interrupt function
MIME-Version: 1.0
Content-Type: multipart/Alternative;
	boundary="----=_Part_176124_1184048470.1183255421507"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_176124_1184048470.1183255421507
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable

 Hi    I'm writing an ac97 driver with interrupt mode,below is my code:stat=
icirqreturn_t ac97_interrupt_handler(int irq,void *dev_id,struct pt_regs *r=
egs){    disable_irq(7);    wake_up_interruptible(ac97_queue);    return IR=
Q_HANDLED;} static int xilinx_ac97_write(struct file *filp,char *buffer,siz=
e_t count,loff_t *ppos){    ......    if(XAC97_isInFIFOFull(baseAddress))  =
      wait_event_interruptible(ac97_queue,...);    else        XAC97_mSetIn=
FifoData(baseAddress,...);    ......}    Int the write function,when the pl=
ay back fifo is not full,I send the PCM code to the fifo,else I make the wr=
ite process sleep,and in the interrupt handler(when the fifo half empty,an =
interrupt occure),I wake up the write process,and go on write PCM code to t=
he fifo.    But I find the play speed is rather faster than regular and can=
't hear the voice(I have set the pcm rate correctly),I don't know why,can a=
nyone give some advice on writing interupt handler or send me a copy of ac9=
7 driver with interrupt mode? thanks a lot
------=_Part_176124_1184048470.1183255421507
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>&nbsp;</DIV>
<DIV>Hi</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I'm writing an ac97 driver with interrupt mode,belo=
w is my code:</DIV>
<DIV>static <FONT size=3D2>irqreturn_t ac97_interrupt_handler(int irq,void =
*dev_id,struct pt_regs *regs)</FONT></DIV>
<DIV><FONT size=3D2>{</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; disable_irq(7);</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; wake_up_interruptible(ac97_queue);</=
FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;</FONT></DIV>
<DIV><FONT size=3D2>}</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>static int xilinx_ac97_write(struct file *filp,char *bu=
ffer,size_t count,loff_t *ppos)</FONT></DIV>
<DIV><FONT size=3D2>{</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; ......</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; if(XAC97_isInFIFOFull(baseAddress))<=
/FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_event_i=
nterruptible(ac97_queue,...);</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; else</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XAC97_mSetIn=
FifoData(baseAddress,...);</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; ......</FONT></DIV>
<DIV><FONT size=3D2>}</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; Int the write function,when the&nbsp=
;play back&nbsp;fifo is not full,I send the PCM code to the fifo,else I mak=
e the write process sleep,and in the interrupt handler(when the fifo half e=
mpty,an interrupt occure),I wake up the write process,and&nbsp;go on write&=
nbsp;PCM code to the fifo.</FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp; But I find the play speed is rather faster than reg=
ular&nbsp;and can't hear the voice(I have set the pcm rate correctly),I don=
't know why,can anyone give some advice on writing interupt handler or send=
 me a copy of ac97 driver with interrupt mode? thanks a lot</DIV><br><!-- f=
ooter --><br><hr>
<a style=3D"font-size:14px;line-height:15px; color:#000; text-decoration:no=
ne" href=3D"http://event.mail.163.com/chanel/xyq.htm?from=3D163_NO1" target=
=3D"_blank"><span style=3D"text-decoration:underline; color:blue">150 =CD=
=F2 =C8=CB =CD=AC =CA=B1 =D4=DA =CD=E6 =B5=C4 =CD=F8 =D3=CE=A3=AC=C4=E3 =B2=
=BB =CA=D4 =CA=D4 =C2=F0 =A3=BF </span> </a>
------=_Part_176124_1184048470.1183255421507--
