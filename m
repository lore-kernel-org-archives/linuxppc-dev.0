Return-Path: <junijoseph@yahoo.co.in>
Received: from web8408.mail.in.yahoo.com (web8408.mail.in.yahoo.com
	[202.43.219.156]) by ozlabs.org (Postfix) with SMTP id EA06C67D23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 10:31:19 +1000 (EST)
Message-ID: <20061026003115.22528.qmail@web8408.mail.in.yahoo.com>
Date: Thu, 26 Oct 2006 01:31:15 +0100 (BST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: System ACE driver - for 2.6 kernel - need help to understand
	xsa_thread
To: Ameet Patil <appatil@cs.york.ac.uk>
In-Reply-To: <45311FE5.3080400@cs.york.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-34179469-1161822675=:22188"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-34179469-1161822675=:22188
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hello all
 
 I am trying to understand the parameters that are sent through "cur_req" function used in funtion xsa_thread in System ACE driver.
 
 In xsa_thread function in the System ACE driver , 
 
 In 2.4 kernel:
 --------------------
 while ((stat = cur_req(&SysAce, sector,
                                        CURRENT->current_nr_sectors,
                                        CURRENT->buffer)) == XST_DEVICE_BUSY)
                         xsa_short_delay();
 
  
 Where as in 2.6 kernel this is changed to 
 ---------------------------------------------------------------
 
  for(i = xsa_cur_req->current_nr_sectors; i > 0; i-=2){
                         xsa_device.req_done = 1;
                         while ((stat = cur_req(&SysAce, sector,
                                         2,
                                         buffer)) == XST_DEVICE_BUSY)
                                 xsa_short_delay();
 #endif
 
 Ameet , could you help me understand the impact of the parameters, especailly the 3rd paramter which is hardcoded in 2.6 kernel.It would be great if you could clarify this in regard to 'mount' command.
 
 Thanks in advance
 Junita
 
 
 
 
 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-34179469-1161822675=:22188
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Hello all<br> <br> I am trying to understand the parameters that are sent through "cur_req" function used in funtion xsa_thread in System ACE driver.<br> <br> In xsa_thread function in the System ACE driver , <br> <br> In 2.4 kernel:<br> --------------------<br> while ((stat = cur_req(&amp;SysAce, sector,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRENT-&gt;current_nr_sectors,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRENT-&gt;buffer)) == XST_DEVICE_BUSY)<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xsa_short_delay();<br> <br> &nbsp;<br> Where as in 2.6 kernel this is changed to <br> ---------------------------------------------------------------<br> <br>  for(i = xsa_cur_req-&gt;current_nr_sectors; i &gt; 0; i-=2){<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xsa_device.req_done = 1;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((stat = cur_req(&amp;SysAce, sector,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2,<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer)) == XST_DEVICE_BUSY)<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xsa_short_delay();<br> #endif<br> <br> Ameet , could you help me understand the impact of the parameters, especailly the 3rd paramter which is hardcoded in 2.6 kernel.It would be great if you could clarify this in regard to 'mount' command.<br> <br> Thanks in advance<br> Junita<br> <br> <br> <br> <p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-34179469-1161822675=:22188--
