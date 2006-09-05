Return-Path: <paravpandit@yahoo.com>
Received: from web36611.mail.mud.yahoo.com (web36611.mail.mud.yahoo.com
	[209.191.85.28]) by ozlabs.org (Postfix) with SMTP id 35799679FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Sep 2006 22:53:35 +1000 (EST)
Message-ID: <20060905125333.78650.qmail@web36611.mail.mud.yahoo.com>
Date: Tue, 5 Sep 2006 05:53:33 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: Re: MPC5200B - FEC Error
To: Ram Prasad H L <hlrprasad@tataelxsi.co.in>, linuxppc-embedded@ozlabs.org
In-Reply-To: <000201c6d0b4$b6d08f50$4129320a@telxsi.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1963365598-1157460813=:78630"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1963365598-1157460813=:78630
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Ram Prasad,
   
  Are you using the BEST COMM APIs in your driver?
  I believe FEC driver needs some rework. Driver tries reinit the device in the interrupt handler itself from where your mpx5xxx_fec_reinit is called.
  fec_reinit() calls fec_open() in the interrupt halder!
   
  Also, 
   
  We did somewhat but is not complete yet.
  If we closely look, I think, typical sequence is init() followed by open().
  In case of reinit(), we missed something or miss to reconfigure something (Mostly the Tx, Rx queue) before we make call to open() similar to init().
   
  Welll, on top of this, I am refering to 2.6.13 code base.
   
  Regards,
  Parav Pandit
   
   
  

Ram Prasad H L <hlrprasad@tataelxsi.co.in> wrote:
  hi all,
this is Ramprasad, and we are using freescale's Lite5200B
using MPC5200B as core, for one of our applications.
The board is booted with u-boot-1.2.2 and linux kernel 2.4.25.

I'm finding a very peculiar problem with the board when I
run my application which extensively uses the FEC for receiving
video and audio streams from network. The application runs fine for
some time say 2-3 hrs and suddenly i'm getting the following error
and the OS starts rebooting.

The error log looks somewhat like this:

NIP: C0124ECC XER: 00000000 LR: C0125028 SP: C01B6270 REGS: c01b61c0 TRAP:
0300 Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000000F0, DSISR: 20000000
TASK = c01b4470[0] 'swapper' Last syscall: 120
last math c228a000 last altivec 00000000
GPR00: 000000F0 C01B6270 C01B4470 00001032 00001032 00000006 C0C11034
C3C61CC0
GPR08: 0000003F 00000000 C01CE9F8 C01CEAD0 00000002 1012A714 03FBA000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 00001032 C3F93000 C0210000
00000000
GPR24: C3C06012 00000045 C01E0000 C0BE1320 0000054E C01CE9E0 C01CEA08
C3CA9A20
Call backtrace:
C0125528 C011AF0C C0006CD8 C0006D98 C0005C40 C00072C8 C00072E4
C0003918 C01CF5B8 000035F0
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
<0>Rebooting in 180 seconds..<4>MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit


Can anyone tell me what is the reason to face such
an error? and how can we avoid this error? any pointers
for overcoming it will be really helpfull as I'm stuck with
this problem since long time.

thanks and regards,

Ramprasad H L

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


 		
---------------------------------
Yahoo! Messenger with Voice. Make PC-to-Phone Calls to the US (and 30+ countries) for 2¢/min or less.
--0-1963365598-1157460813=:78630
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Ram Prasad,</div>  <div>&nbsp;</div>  <div>Are you using the BEST COMM APIs in your driver?</div>  <div>I believe FEC driver needs some rework. Driver tries reinit the device in the interrupt handler itself from where your mpx5xxx_fec_reinit is called.</div>  <div>fec_reinit() calls fec_open() in the interrupt halder!</div>  <div>&nbsp;</div>  <div>Also, </div>  <div>&nbsp;</div>  <div>We did somewhat but is not complete yet.</div>  <div>If we closely look, I think, typical sequence is init() followed by open().</div>  <div>In case of reinit(), we missed something or miss to reconfigure something (Mostly the Tx, Rx queue) before we make call to open() similar to init().</div>  <div>&nbsp;</div>  <div>Welll, on top of this, I am refering to 2.6.13 code base.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Parav Pandit</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div><BR><BR><B><I>Ram Prasad H L &lt;hlrprasad@tataelxsi.co.in&gt;</I></B> wrote:</div>  <BLOCKQUOTE
 class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">hi all,<BR>this is Ramprasad, and we are using freescale's Lite5200B<BR>using MPC5200B as core, for one of our applications.<BR>The board is booted with u-boot-1.2.2 and linux kernel 2.4.25.<BR><BR>I'm finding a very peculiar problem with the board when I<BR>run my application which extensively uses the FEC for receiving<BR>video and audio streams from network. The application runs fine for<BR>some time say 2-3 hrs and suddenly i'm getting the following error<BR>and the OS starts rebooting.<BR><BR>The error log looks somewhat like this:<BR><BR>NIP: C0124ECC XER: 00000000 LR: C0125028 SP: C01B6270 REGS: c01b61c0 TRAP:<BR>0300 Not tainted<BR>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11<BR>DAR: 000000F0, DSISR: 20000000<BR>TASK = c01b4470[0] 'swapper' Last syscall: 120<BR>last math c228a000 last altivec 00000000<BR>GPR00: 000000F0 C01B6270 C01B4470 00001032 00001032 00000006
 C0C11034<BR>C3C61CC0<BR>GPR08: 0000003F 00000000 C01CE9F8 C01CEAD0 00000002 1012A714 03FBA000<BR>00000000<BR>GPR16: 00000001 00000001 FFFFFFFF 007FFF00 00001032 C3F93000 C0210000<BR>00000000<BR>GPR24: C3C06012 00000045 C01E0000 C0BE1320 0000054E C01CE9E0 C01CEA08<BR>C3CA9A20<BR>Call backtrace:<BR>C0125528 C011AF0C C0006CD8 C0006D98 C0005C40 C00072C8 C00072E4<BR>C0003918 C01CF5B8 000035F0<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>panic: Aiee, killing interrupt handler!<BR>In interrupt handler - not syncing<BR>&lt;0&gt;Rebooting in 180
 seconds..&lt;4&gt;MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR>MPC5xxx_FEC_IEVENT_RFIFO_ERROR<BR>mpc5xxx_fec_reinit<BR><BR><BR>Can anyone tell me what is the reason to face such<BR>an error? and how can we avoid this error? any pointers<BR>for overcoming it will be really helpfull as I'm stuck with<BR>this problem since long time.<BR><BR>thanks and
 regards,<BR><BR>Ramprasad H L<BR><BR>_______________________________________________<BR>Linuxppc-embedded mailing list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman1/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Make PC-to-Phone Calls</a> to the US (and 30+ countries) for 2¢/min or less.
--0-1963365598-1157460813=:78630--
