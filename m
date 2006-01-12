Return-Path: <happa@wmlab.csie.ncu.edu.tw>
Received: from wmlab.csie.ncu.edu.tw (wmlab.csie.ncu.edu.tw [140.115.155.134])
	by ozlabs.org (Postfix) with ESMTP id F29BE689FA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 17:45:43 +1100 (EST)
Received: from 140.115.155.134 (localhost.csie.ncu.edu.tw [127.0.0.1])
	by wmlab.csie.ncu.edu.tw (Postfix) with SMTP id CB1581100F2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 14:45:42 +0800 (CST)
From: happa@wmlab.csie.ncu.edu.tw
To: linuxppc-embedded@ozlabs.org
Date: Thu, 12 Jan 2006 14:45:42 +0800(CST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--43C5FB16000C977C@wmlab.csie.ncu.edu.tw"
Message-Id: <20060112064542.CB1581100F2@wmlab.csie.ncu.edu.tw>
Subject: About MMU setting in MPC8245 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

----43C5FB16000C977C@wmlab.csie.ncu.edu.tw
Content-Type: text/plain; Charset=Big5;
Content-Transfer-Encoding: 8bit

Hi, Mark,
    Thanks for your information.
    
>Are you in PCI host mode?  If so, the first sentence of chapter 3--
>Address Maps of the 8245 manual states:

>	"The MPC8245 in PCI host mode supports an address mapping
>	configuration that is designated as address map B."

>Map B == CHRP mapping.

Yes, my CPU is in PCI host mode, and my address is use Map B.

I'm figure out my problem.

My kernel seems work fine until it calling run_init_process("/sbin/init").

run_init_process("/sbin/init")
   |
   v
..wait until the file got from NFS .....     
   |
   v 
 load_elf_binary()
   |
   v
 flush_old_exec()
   |
   v
 exec_mmap()
   |
   v
 activate_mm() ---> After this function is called any virtual memory operations
                    (access address out of my physical dram range), will let kernel jump into exception mode.
"Oops: kernel access of bad area, sig: 11 [#2]"


So I guess the problem is relative to mmu setting.
Would you give me any idea which part I need to check?

Thanks.

/Wen
----43C5FB16000C977C@wmlab.csie.ncu.edu.tw--
