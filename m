Return-Path: <warrier@optovia.com>
Received: from mail.optovia.com (unknown [65.126.156.196])
	by ozlabs.org (Postfix) with ESMTP id C1AB467A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 05:21:57 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OF1DBAC725.C46FDD91-ON85256FEA.00673BB3-85256FEA.0068EE8C@optovia.com>
From: warrier@optovia.com
Date: Thu, 21 Apr 2005 15:06:08 -0400
Content-Type: text/plain; charset="us-ascii"
Subject: TCP issues
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi
   I've got a peculiar problem with TCP  on the kernel that I am running. 
It's version 2.4.25 and the CPU is MPC5200. I'm using the linux kernel 
distribution that came with the DENX distribution. 
Anyway it prints out Yellow Dog Linux 3.0 

While doing a file transfer especially with files that are larger than 7K 
(using ftp) the card hangs.
Using a combination of tcpdump and some printk's I've noticed that the tcp 
checksum is wrong in these cases. The IP header checksum is fine. The 
corruption  seems to occur before tcp_tansmit_skb is called. The 
corruption is obviously in the tcp buffer as the partial checksums are not 
altered as the the packet progresses. It seems that the corruption occurs 
after the partial checksum has been calculated. 
I'm using the same kernel on an 8270 based card without any problems.

Alternately if I use "printk" at some locations the problem disappears. It 
seems as if there is some race condition that causes the corruption.

Has anybody come across this buffer corruption before? I'm not sure where 
to post this problem.

Thanks

S
