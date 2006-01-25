Return-Path: <lcsquare2@yahoo.com.hk>
Received: from web53711.mail.yahoo.com (web53711.mail.yahoo.com
	[206.190.39.60]) by ozlabs.org (Postfix) with SMTP id 4FE8868A87
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 03:04:30 +1100 (EST)
Message-ID: <20060125160429.19231.qmail@web53711.mail.yahoo.com>
Date: Thu, 26 Jan 2006 00:04:29 +0800 (CST)
From: Lo Chun Chung <lcsquare2@yahoo.com.hk>
Subject: Enable Billionton PCMCIA Bluetooth in MPC860 system (again)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1215934682-1138205069=:94293"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1215934682-1138205069=:94293
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Dear all,

  Hi again, I have asked a same question here before (http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021617.html), now I have some discoveries ... but I still do not know how to solve.
   
  (My system is a MPC860 Processor Card, plus a custom made PCB to provide a PCMCIA interface, now the latest progress is I can use PCMCIA WLAN cards in this system without any problem. But my main target is use a PCMCIA Bluetooth card ... )
   
  I have noticed when I load up the "serial.o", function "rs_init" must be executed, inside this function call, a function "autoconfig" will be called.
   
  My problem is due to this "autoconfig", it will try to parse a standard uart to determine what is its model. But my case is my standard uart is a PCMCIA Bluetooth Card.
   
  I can simply comment out the function "rs_init" to let the "serial.o" do not run this function. But later when I load the module "serial_cs", many problems happened. (seems "rs_init" will initialize other things that I have not done ...)
   
  Since "serial_cs" (the pcmcia uart driver) needs two function calls in "serial.o" (they are: resgister_serial() and unregister_serial() ), so I really need load up "serial.o" before I  can load up "serial_cs.o"
   
  So my problem is, how can I setup such driver in MPC860 environment with a PCMCIA ? 
   
  Thanks all~
  
Best regards,
Chung



Best regards,
Chung
_______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-1215934682-1138205069=:94293
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Dear all,<BR></DIV>  <DIV>Hi again, I have asked a same question here before (<A href="http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021617.html">http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021617.html</A>), now I have some discoveries ... but I still do not know how to solve.</DIV>  <DIV>&nbsp;</DIV>  <DIV>(My system is a MPC860 Processor Card, plus a custom made PCB to provide a PCMCIA interface, now the latest progress is I can use PCMCIA WLAN cards in this system without any problem. But my main target is use a PCMCIA Bluetooth card ... )</DIV>  <DIV>&nbsp;</DIV>  <DIV>I have noticed when&nbsp;I load up the "serial.o", function "rs_init" must be executed, inside this function call, a function "autoconfig" will be called.</DIV>  <DIV>&nbsp;</DIV>  <DIV>My problem is due to this "autoconfig", it will try to parse a standard uart to determine what is its model. But my case is my standard uart is a PCMCIA Bluetooth Card.</DIV>  <DIV>&nbsp;</DIV> 
 <DIV>I can simply comment out the function "rs_init" to let the "serial.o" do not run this function. But later when I load the module "serial_cs", many problems happened. (seems "rs_init" will initialize other things that I have not done ...)</DIV>  <DIV>&nbsp;</DIV>  <DIV>Since "serial_cs" (the pcmcia uart driver) needs two function calls in "serial.o" (they are: resgister_serial() and unregister_serial() ), so I really need load up "serial.o" before I&nbsp; can load up "serial_cs.o"</DIV>  <DIV>&nbsp;</DIV>  <DIV>So my problem is, how can I setup such driver in MPC860 environment with a PCMCIA ? </DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks all~</DIV>  <DIV><BR>Best regards,<BR>Chung<BR></DIV><BR><BR>Best regards,<br>Chung<p>_______________________________________<br> YM - 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-1215934682-1138205069=:94293--
