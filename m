Return-Path: <dy_wang@yahoo.com>
Received: from web51908.mail.yahoo.com (web51908.mail.yahoo.com
	[206.190.48.71]) by ozlabs.org (Postfix) with SMTP id 23D55DDF4A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 04:31:54 +1100 (EST)
Date: Wed, 31 Jan 2007 09:24:10 -0800 (PST)
From: wang dengyi <dy_wang@yahoo.com>
Subject: lite5200b ethernet statistics always is 0
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <291223.31248.qm@web51908.mail.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On my development board:lite5200b, All value from the
ethernet statistics is 0. Please see the ifconfig
output at the end of my email.

The CPU is MPC5200b and the kernel is 2.4.14. 

I checked the driver code:
linux/drivers/net/fec_mpc52xx/fec.c. The get_stats()
function looks fine. The function read the statistics
register using in_be32() function. But it always
returns 0. The following line is my code to print the
value from the register. The output is 0 for the
register. 
printk(KERN_ERR "%s:%d: rmon_r_octest: %x\n",
__FUNCTION__, __LINE__, in_be32(&fec->rmon_r_octets));

Any idea, how do I fix it?

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr
CA:2A:AA:AB:EA:2A
          UP BROADCAST RUNNING MULTICAST  MTU:1500 
Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0
frame:0
          TX packets:0 errors:0 dropped:0 overruns:0
carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:43

Thanks in advance.


Regards,

Dengyi Wang


 
____________________________________________________________________________________
Need a quick answer? Get one in minutes from people who know.
Ask your question on www.Answers.yahoo.com
