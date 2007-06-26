Return-Path: <chenxurcy@yahoo.com.cn>
Received: from web92009.mail.cnb.yahoo.com (web92009.mail.cnb.yahoo.com
	[203.209.230.56]) by ozlabs.org (Postfix) with SMTP id 26A71DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 15:59:35 +1000 (EST)
Date: Tue, 26 Jun 2007 13:59:33 +0800 (CST)
From: xu chen <chenxurcy@yahoo.com.cn>
Subject: Who can help me with my NFS?
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1417927667-1182837573=:20019"
Message-ID: <947266.20019.qm@web92009.mail.cnb.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1417927667-1182837573=:20019
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

I ported my opb_ethernet driver to the ml403 board, with the reference system provided by Xilinx Co. Now I can ping the host with the board, and can also ping the board with PC. But I can't mount the NFS of my PC. The host configuration is correct,  and the host can also be mounted by other PCs. Here is my tcpdump log when the board mount the PC's NFS, PC's IP: 192.168.1.107; board's IP: 192.168.1.134

/* log started */
20:14:42.349932 arp who-has 192.168.1.107 tell 192.168.1.134
20:14:47.070616 arp reply 192.168.1.107 is-at 00:e0:4c:fe:d0:f1 (oui Unknown)
20:14:42.394658 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: S 1146939992:1146939992(0) win 5840 <mss 1460,sackOK,timestamp 196450 0,nop,wscale 1>
20:14:42.394707 IP 192.168.1.107.sunrpc > 192.168.1.134.cadlock: S 1643811256:1643811256(0) ack 1146939993 win 5792 <mss 1460,sackOK,timestamp 27240469 196450,nop,wscale 2>
20:14:42.446740 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: . ack 1 win 2920 <nop,nop,timestamp 196477 27240469>
20:14:42.498840 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 196490 27240469>
20:14:42.871984 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 196584 27240469>
20:14:43.568070 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 196758 27240469>
20:14:44.912202 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 197094 27240469>
20:14:47.552563 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 197754 27240469>
20:14:52.785247 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 199062 27240469>
20:15:03.202489 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 201666 27240469>
20:15:23.988960 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 206862 27240469>
20:15:28.989426 arp who-has 192.168.1.107 tell 192.168.1.134
20:15:28.989446 arp reply 192.168.1.107 is-at 00:e0:4c:fe:d0:f1 (oui Unknown)
20:15:42.557376 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: F 45:45(0) ack 1 win 2920 <nop,nop,timestamp 211503 27240469>
20:15:42.557423 IP 192.168.1.107.sunrpc > 192.168.1.134.cadlock: . ack 1 win 1448 <nop,nop,timestamp 27255509 196477,nop,nop,sack 1 {45:46}>
20:15:42.610524 IP 192.168.1.134.rtip > 192.168.1.107.rlzdbase: UDP, length 100
20:15:45.660481 IP 192.168.1.134.rtip > 192.168.1.107.rlzdbase: UDP, length 100
20:15:47.555896 arp who-has 192.168.1.134 tell 192.168.1.107
20:15:47.605255 arp reply 192.168.1.134 is-at 00:0a:35:01:7e:d1 (oui Unknown)
20:15:48.708674 IP 192.168.1.134.rtip > 192.168.1.107.rlzdbase: UDP, length 100
20:15:51.757068 IP 192.168.1.134.rtip > 192.168.1.107.rlzdbase: UDP, length 100
20:15:54.805366 IP 192.168.1.134.rtip > 192.168.1.107.rlzdbase: UDP, length 100
20:15:57.853759 IP 192.168.1.134.rtip > 192.168.1.107.rlzdbase: UDP, length 100
20:16:00.902163 IP 192.168.1.134.rtip > 192.168.1.107.rlzdbase: UDP, length 100
20:16:05.513866 IP 192.168.1.134.cadlock > 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 <nop,nop,timestamp 217242 27255509>

/* log ended */


 		
---------------------------------
 ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
--0-1417927667-1182837573=:20019
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

I ported my opb_ethernet driver to the ml403 board, with the reference system provided by Xilinx Co. Now I can ping the host with the board, and can also ping the board with PC. But I can't mount the NFS of my PC. The host configuration is correct,&nbsp; and the host can also be mounted by other PCs. Here is my tcpdump log when the board mount the PC's NFS, PC's IP: 192.168.1.107; board's IP: 192.168.1.134<br><br>/* log started */<br>20:14:42.349932 arp who-has 192.168.1.107 tell 192.168.1.134<br>20:14:47.070616 arp reply 192.168.1.107 is-at 00:e0:4c:fe:d0:f1 (oui Unknown)<br>20:14:42.394658 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: S 1146939992:1146939992(0) win 5840 &lt;mss 1460,sackOK,timestamp 196450 0,nop,wscale 1&gt;<br>20:14:42.394707 IP 192.168.1.107.sunrpc &gt; 192.168.1.134.cadlock: S 1643811256:1643811256(0) ack 1146939993 win 5792 &lt;mss 1460,sackOK,timestamp 27240469 196450,nop,wscale 2&gt;<br>20:14:42.446740 IP 192.168.1.134.cadlock &gt;
 192.168.1.107.sunrpc: . ack 1 win 2920 &lt;nop,nop,timestamp 196477 27240469&gt;<br>20:14:42.498840 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 196490 27240469&gt;<br>20:14:42.871984 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 196584 27240469&gt;<br>20:14:43.568070 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 196758 27240469&gt;<br>20:14:44.912202 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 197094 27240469&gt;<br>20:14:47.552563 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 197754 27240469&gt;<br>20:14:52.785247 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 199062 27240469&gt;<br>20:15:03.202489 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P
 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 201666 27240469&gt;<br>20:15:23.988960 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 206862 27240469&gt;<br>20:15:28.989426 arp who-has 192.168.1.107 tell 192.168.1.134<br>20:15:28.989446 arp reply 192.168.1.107 is-at 00:e0:4c:fe:d0:f1 (oui Unknown)<br>20:15:42.557376 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: F 45:45(0) ack 1 win 2920 &lt;nop,nop,timestamp 211503 27240469&gt;<br>20:15:42.557423 IP 192.168.1.107.sunrpc &gt; 192.168.1.134.cadlock: . ack 1 win 1448 &lt;nop,nop,timestamp 27255509 196477,nop,nop,sack 1 {45:46}&gt;<br>20:15:42.610524 IP 192.168.1.134.rtip &gt; 192.168.1.107.rlzdbase: UDP, length 100<br>20:15:45.660481 IP 192.168.1.134.rtip &gt; 192.168.1.107.rlzdbase: UDP, length 100<br>20:15:47.555896 arp who-has 192.168.1.134 tell 192.168.1.107<br>20:15:47.605255 arp reply 192.168.1.134 is-at 00:0a:35:01:7e:d1 (oui Unknown)<br>20:15:48.708674 IP
 192.168.1.134.rtip &gt; 192.168.1.107.rlzdbase: UDP, length 100<br>20:15:51.757068 IP 192.168.1.134.rtip &gt; 192.168.1.107.rlzdbase: UDP, length 100<br>20:15:54.805366 IP 192.168.1.134.rtip &gt; 192.168.1.107.rlzdbase: UDP, length 100<br>20:15:57.853759 IP 192.168.1.134.rtip &gt; 192.168.1.107.rlzdbase: UDP, length 100<br>20:16:00.902163 IP 192.168.1.134.rtip &gt; 192.168.1.107.rlzdbase: UDP, length 100<br>20:16:05.513866 IP 192.168.1.134.cadlock &gt; 192.168.1.107.sunrpc: P 1:45(44) ack 1 win 2920 &lt;nop,nop,timestamp 217242 27255509&gt;<br><br>/* log ended */<br><br><p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com/" target=blank> 
ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
</a>
--0-1417927667-1182837573=:20019--
