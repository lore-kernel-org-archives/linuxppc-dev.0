Return-Path: <jiehanca@yahoo.com.cn>
Received: from web15105.mail.cnb.yahoo.com (web15105.mail.cnb.yahoo.com
	[202.165.103.74]) by ozlabs.org (Postfix) with SMTP id C9B3467B55
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 19:11:05 +1000 (EST)
Message-ID: <20060816091103.75046.qmail@web15105.mail.cnb.yahoo.com>
Date: Wed, 16 Aug 2006 02:11:03 -0700 (PDT)
From: jie han <jiehanca@yahoo.com.cn>
Subject: boot kernel 2.6.18 is hang???
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1526000851-1155719463=:74824"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1526000851-1155719463=:74824
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


I am trying to take a working embedded linux system from kernel 2.4 to 
2.6. The hardware is a custom board using a mpc8270vr processor.
The working system uses u-boot 1.1.4 with linux kernel 2.4.24.

I am using the same u-boot and I am trying to port linux kernel 2.6.18. 
I believe I have done everything required to get the kernel booting. However, the kernel 
seems to hang after being uncompressed. Here is what I see after running 
bootm from u-boot:

OLT=> tftp 500000 uImage
Using FCC1 ETHERNET device
TFTP from server 192.168.2.45; our IP address is 192.168.2.109
Filename 'uImage'.
Load address: 0x500000
Loading: #################################################################
         #################################################################
         #################################################################
done
Bytes transferred = 995314 (f2ff2 hex)
OLT=> bootm 500000
## Booting image at 00500000 ...
   Image Name:   Linux-2.6.18/Ocean BoradBand Ltd
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    995250 Bytes = 971.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

log_buf context is
OLT=> md 1b9d60 100
001b9d60: c020c0a4 00004000 00000000 ffffffff    . ....@.........
001b9d70: 00000001 c01b9d74 c01b9d74 00000001    .......t...t....
001b9d80: c01b9d80 c01b9d80 ffffffff 61637175    ............acqu
001b9d90: 6972655f 636f6e73 6f6c655f 73656d00    ire_console_sem.
001b9da0: 63616c6c 5f636f6e 736f6c65 5f647269    call_console_dri
001b9db0: 76657273 00000000 ffffffff 00000001    vers............
001b9dc0: 00001388 00000000 00000000 c001571c    ..............W.
001b9dd0: 00000000 c001589c 00000000 00000000    ......X.........
001b9de0: 00000000 00000000 00000000 00000000    ................
001b9df0: 00000000 00000000 00000000 00000000    ................
001b9e00: 00000000 00000000 00000000 00000000    ................
001b9e10: 00000000 00000000 00000000 00000000    ................
001b9e20: 00000000 00000000 00000000 00000000    ................
001b9e30: 00000000 00000000 00000001 65786974    ............exit
001b9e40: 5f6d6d00 5f5f6578 69745f73 69676e61    _mm.__exit_signa
001b9e50: 6c000000 72656c65 6173655f 7461736b    l...release_task
001b9e60: 00000000 63686f6f 73655f6e 65775f70    ....choose_new_p
001b9e70: 6172656e 74000000 666f7267 65745f6f    arent...forget_o
001b9e80: 72696769 6e616c5f 70617265 6e740000    riginal_parent..
001b9e90: 65786974 5f6e6f74 69667900 646f5f65    exit_notify.do_e
001b9ea0: 78697400 646f5f67 726f7570 5f657869    xit.do_group_exi
001b9eb0: 74000000 77616974 5f746173 6b5f636f    t...wait_task_co
001b9ec0: 6e74696e 75656400 77616974 5f746173    ntinued.wait_tas
001b9ed0: 6b5f7a6f 6d626965 00000000 77616974    k_zombie....wait
001b9ee0: 5f746173 6b5f7374 6f707065 64000000    _task_stopped...
001b9ef0: 646f5f77 61697400 0000000a 00000001    do_wait.........
001b9f00: c0019b50 00000000 00000000 6370755f    ...P........cpu_
001b9f10: 63616c6c 6261636b 00000000 00000001    callback........
001b9f20: 00000001 5f5f6c6f 63616c5f 62685f65    ....__local_bh_e
001b9f30: 6e61626c 65000000 00000001 00000001    nable...........
001b9f40: 5f6c6f63 616c5f62 685f656e 61626c65    _local_bh_enable
001b9f50: 00000000 7461736b 6c65745f 61637469    ....tasklet_acti
001b9f60: 6f6e0000 7461736b 6c65745f 68695f61    on..tasklet_hi_a
001b9f70: 6374696f 6e000000 00000001 00000001    ction...........
001b9f80: 6c6f6361 6c5f6268 5f656e61 626c6500    local_bh_enable.
001b9f90: 00000001 6c6f6361 6c5f6268 5f656e61    ....local_bh_ena
001b9fa0: 626c655f 69700000 00000001 5f5f6c6f    ble_ip......__lo
001b9fb0: 63616c5f 62685f64 69736162 6c650000    cal_bh_disable..
001b9fc0: 00000000 ffffffff c018a9b0 00000200    ................
001b9fd0: 00000000 00000000 00000000 00000000    ................
001b9fe0: ffffffff c018a9b8 00000100 00000000    ................
001b9ff0: 00000000 00000000 00000000 c0075590    ..............U.
001ba000: c0075878 00000000 00000000 00000000    ..Xx............
001ba010: 00000000 00000000 00000000 00000000    ................
001ba020: 00000000 00000000 c001a53c 00000000    ...........<....
001ba030: c0075014 00000000 00000000 00000000    ..P.............
001ba040: 00000000 00000000 00000000 00000000    ................
001ba050: 00000000 00000000 00000000 00000000    ................
001ba060: 00000000 00000000 00000000 00000000    ................
001ba070: c0075590 c0075878 00000000 00000000    ..U...Xx........


Any ideas would be appreciated.

Regards,

Jie





 		
---------------------------------
Do you Yahoo!?
 Next-gen email? Have it all with the  all-new Yahoo! Mail Beta.
--0-1526000851-1155719463=:74824
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<pre>I am trying to take a working embedded linux system from kernel 2.4 to <br>2.6. The hardware is a custom board using a mpc8270vr processor.<br>The working system uses u-boot 1.1.4 with linux kernel 2.4.24.<br><br>I am using the same u-boot and I am trying to port linux kernel 2.6.18. <br>I believe I have done everything required to get the kernel booting. However, the kernel <br>seems to hang after being uncompressed. Here is what I see after running <br>bootm from u-boot:<br><br>OLT=&gt; tftp 500000 uImage<br>Using FCC1 ETHERNET device<br>TFTP from server 192.168.2.45; our IP address is 192.168.2.109<br>Filename 'uImage'.<br>Load address: 0x500000<br>Loading: #################################################################<br>         #################################################################<br>         #################################################################<br>done<br>Bytes transferred = 995314 (f2ff2 hex)<br>OLT=&gt; bootm 500000<br>## Booting
 image at 00500000 ...<br>   Image Name:   Linux-2.6.18/Ocean BoradBand Ltd<br>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)<br>   Data Size:    995250 Bytes = 971.9 kB<br>   Load Address: 00000000<br>   Entry Point:  00000000<br>   Verifying Checksum ... OK<br>   Uncompressing Kernel Image ... OK<br><br>log_buf context is<br>OLT=&gt; md 1b9d60 100<br>001b9d60: c020c0a4 00004000 00000000 ffffffff    . ....@.........<br>001b9d70: 00000001 c01b9d74 c01b9d74 00000001    .......t...t....<br>001b9d80: c01b9d80 c01b9d80 ffffffff 61637175    ............acqu<br>001b9d90: 6972655f 636f6e73 6f6c655f 73656d00    ire_console_sem.<br>001b9da0: 63616c6c 5f636f6e 736f6c65 5f647269    call_console_dri<br>001b9db0: 76657273 00000000 ffffffff 00000001    vers............<br>001b9dc0: 00001388 00000000 00000000 c001571c    ..............W.<br>001b9dd0: 00000000 c001589c 00000000 00000000    ......X.........<br>001b9de0: 00000000 00000000 00000000 00000000   
 ................<br>001b9df0: 00000000 00000000 00000000 00000000    ................<br>001b9e00: 00000000 00000000 00000000 00000000    ................<br>001b9e10: 00000000 00000000 00000000 00000000    ................<br>001b9e20: 00000000 00000000 00000000 00000000    ................<br>001b9e30: 00000000 00000000 00000001 65786974    ............exit<br>001b9e40: 5f6d6d00 5f5f6578 69745f73 69676e61    _mm.__exit_signa<br>001b9e50: 6c000000 72656c65 6173655f 7461736b    l...release_task<br>001b9e60: 00000000 63686f6f 73655f6e 65775f70    ....choose_new_p<br>001b9e70: 6172656e 74000000 666f7267 65745f6f    arent...forget_o<br>001b9e80: 72696769 6e616c5f 70617265 6e740000    riginal_parent..<br>001b9e90: 65786974 5f6e6f74 69667900 646f5f65    exit_notify.do_e<br>001b9ea0: 78697400 646f5f67 726f7570 5f657869    xit.do_group_exi<br>001b9eb0: 74000000 77616974 5f746173 6b5f636f    t...wait_task_co<br>001b9ec0: 6e74696e 75656400 77616974 5f746173   
 ntinued.wait_tas<br>001b9ed0: 6b5f7a6f 6d626965 00000000 77616974    k_zombie....wait<br>001b9ee0: 5f746173 6b5f7374 6f707065 64000000    _task_stopped...<br>001b9ef0: 646f5f77 61697400 0000000a 00000001    do_wait.........<br>001b9f00: c0019b50 00000000 00000000 6370755f    ...P........cpu_<br>001b9f10: 63616c6c 6261636b 00000000 00000001    callback........<br>001b9f20: 00000001 5f5f6c6f 63616c5f 62685f65    ....__local_bh_e<br>001b9f30: 6e61626c 65000000 00000001 00000001    nable...........<br>001b9f40: 5f6c6f63 616c5f62 685f656e 61626c65    _local_bh_enable<br>001b9f50: 00000000 7461736b 6c65745f 61637469    ....tasklet_acti<br>001b9f60: 6f6e0000 7461736b 6c65745f 68695f61    on..tasklet_hi_a<br>001b9f70: 6374696f 6e000000 00000001 00000001    ction...........<br>001b9f80: 6c6f6361 6c5f6268 5f656e61 626c6500    local_bh_enable.<br>001b9f90: 00000001 6c6f6361 6c5f6268 5f656e61    ....local_bh_ena<br>001b9fa0: 626c655f 69700000 00000001 5f5f6c6f   
 ble_ip......__lo<br>001b9fb0: 63616c5f 62685f64 69736162 6c650000    cal_bh_disable..<br>001b9fc0: 00000000 ffffffff c018a9b0 00000200    ................<br>001b9fd0: 00000000 00000000 00000000 00000000    ................<br>001b9fe0: ffffffff c018a9b8 00000100 00000000    ................<br>001b9ff0: 00000000 00000000 00000000 c0075590    ..............U.<br>001ba000: c0075878 00000000 00000000 00000000    ..Xx............<br>001ba010: 00000000 00000000 00000000 00000000    ................<br>001ba020: 00000000 00000000 c001a53c 00000000    ...........&lt;....<br>001ba030: c0075014 00000000 00000000 00000000    ..P.............<br>001ba040: 00000000 00000000 00000000 00000000    ................<br>001ba050: 00000000 00000000 00000000 00000000    ................<br>001ba060: 00000000 00000000 00000000 00000000    ................<br>001ba070: c0075590 c0075878 00000000 00000000    ..U...Xx........<br><br><br>Any ideas would be
 appreciated.<br><br>Regards,<br><br>Jie<br><br><br><br></pre><p>&#32;
		<hr size=1>Do you Yahoo!?<br> Next-gen email? Have it all with the <a href="http://us.rd.yahoo.com/evt=42241/*http://advision.webevents.yahoo.com/handraisers"> all-new Yahoo! Mail Beta.</a>
--0-1526000851-1155719463=:74824--
