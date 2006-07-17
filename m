Return-Path: <scotto2hot-green@yahoo.com>
Received: from web33302.mail.mud.yahoo.com (web33302.mail.mud.yahoo.com
	[68.142.206.117]) by ozlabs.org (Postfix) with SMTP id A885367B95
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 03:01:28 +1000 (EST)
Message-ID: <20060717165238.65999.qmail@web33302.mail.mud.yahoo.com>
Date: Mon, 17 Jul 2006 09:52:38 -0700 (PDT)
From: scott <scotto2hot-green@yahoo.com>
Subject: XUP Linux Envirnment, Hi Everyone!
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2037383298-1153155158=:65987"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2037383298-1153155158=:65987
Content-Type: text/plain; charset=us-ascii

Hey list, I'm new here so I thought I'd introduce myself a bit.  I'm a grad student at the University of Colorado Boulder, and am researching novel FPGA reconfiguration techniques this summer.  Our focus is on Xilinx parts and their partial reconfiguration features.  Our goal is to use active reconfiguration to move functional blocks around an FPGA as needed for space-based mission survivability.

Anyway, in order to do this I first need to get a Linux envirnment up and running on my Xilinx XUP board.  This board has a Virtex II Pro FPGA with dual PPC405 cores built-in.  I have a basic Linux install built up using the EMPART tutorial (http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml) and other pages it references.  I have followed these instructions exactly, including busybox and Linux kernel versions (1.1.0 and 2.4.26, respectively) and everything looks swell EXCEPT:  I can't manage to communicate with my custom IP hanging off the OPB bus.  Actually, I can't manage to communicate with any peripherals at all off the OPB bus.

As per the EMPART tutorial's recommendations, here's how I attempt IP access:

  fd = open("/dev/mem", O_RDWR);
  ptr = MAP_FAILED; // Initialize to bad value
  ptr = (int *) mmap(0, 256, PROT_READ|PROT_WRITE, MAP_SHARED, fd, USER_LOGIC_BASEADDR);

  if(ptr==MAP_FAILED) {
    printf("Err: cannot access address!\n");
    return -1;
  }

  *ptr = 0xA;

The mmap call appears to work, and returns a pointer to virtual memory that supposedly references the physical address my IP is located at.  However, when I try to read or write to this pointer I just get a rather ambiguous "bus error".

Some random things I have tried:
- setting dugging for devfs
  - returns no unusual messages
- numerous scans through kernel config params looking for some sort of MMU settings or something
- setting a pointer directly to the physical address of the peripheral
  - yeah, right...
- mapping a pointer to another established IP, in this case UART
  - same problem

Anyone have any experience with this topic?  Any suggestions at all?  Do you think it has something to do w/ the MMU of the PPC405, or am I way off base here?  I know this isn't an FPGA forum, but then I don't think there exists a forum which exactly meets my needs. :)

Thanks much, --scott



--0-2037383298-1153155158=:65987
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt">Hey list, I'm new here so I thought I'd introduce myself a bit.&nbsp; I'm a grad student at the University of Colorado Boulder, and am researching novel FPGA reconfiguration techniques this summer.&nbsp; Our focus is on Xilinx parts and their partial reconfiguration features.&nbsp; Our goal is to use active reconfiguration to move functional blocks around an FPGA as needed for space-based mission survivability.<br><br><span>Anyway, in order to do this I first need to get a Linux envirnment up and running on my Xilinx XUP board.&nbsp; This board has a Virtex II Pro FPGA with dual PPC405 cores built-in.&nbsp; I have a basic Linux install built up using the EMPART tutorial (<a target="_blank"
 href="http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml">http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml</a>) and other pages it references.&nbsp; I have followed these instructions exactly, including busybox and Linux kernel versions (1.1.0 and 2.4.26, respectively) and everything looks swell EXCEPT:&nbsp; I can't manage to communicate with my custom IP hanging off the OPB bus.&nbsp; Actually, I can't manage to communicate with any peripherals at all off the OPB bus.</span><br><br>As per the EMPART tutorial's recommendations, here's how I attempt IP access:<br><br><span style="font-family: courier,monaco,monospace,sans-serif;">&nbsp; fd = open("/dev/mem", O_RDWR);</span><br style="font-family: courier,monaco,monospace,sans-serif;"><span style="font-family: courier,monaco,monospace,sans-serif;">&nbsp; ptr = MAP_FAILED; // Initialize to bad value</span><br style="font-family: courier,monaco,monospace,sans-serif;"><span
 style="font-family: courier,monaco,monospace,sans-serif;">&nbsp; ptr = (int *) mmap(0, 256, PROT_READ|PROT_WRITE, MAP_SHARED, fd, USER_LOGIC_BASEADDR);</span><br style="font-family: courier,monaco,monospace,sans-serif;"><br style="font-family: courier,monaco,monospace,sans-serif;"><span style="font-family: courier,monaco,monospace,sans-serif;">&nbsp; if(ptr==MAP_FAILED) {</span><br style="font-family: courier,monaco,monospace,sans-serif;"><span style="font-family: courier,monaco,monospace,sans-serif;">&nbsp;&nbsp;&nbsp; printf("Err: cannot access address!\n");</span><br style="font-family: courier,monaco,monospace,sans-serif;"><span style="font-family: courier,monaco,monospace,sans-serif;">&nbsp;&nbsp;&nbsp; return -1;</span><br style="font-family: courier,monaco,monospace,sans-serif;"><span style="font-family: courier,monaco,monospace,sans-serif;">&nbsp; }</span><br style="font-family: courier,monaco,monospace,sans-serif;"><br style="font-family:
 courier,monaco,monospace,sans-serif;"><span style="font-family: courier,monaco,monospace,sans-serif;">&nbsp; *ptr = 0xA;</span><br style="font-family: courier,monaco,monospace,sans-serif;"><br>The mmap call appears to work, and returns a pointer to virtual memory that supposedly references the physical address my IP is located at.&nbsp; However, when I try to read or write to this pointer I just get a rather ambiguous "bus error".<br><br>Some random things I have tried:<br>- setting dugging for devfs<br>&nbsp; - returns no unusual messages<br>- numerous scans through kernel config params looking for some sort of MMU settings or something<br>- setting a pointer directly to the physical address of the peripheral<br>&nbsp; - yeah, right...<br>- mapping a pointer to another established IP, in this case UART<br>&nbsp; - same problem<br><br>Anyone have any experience with this topic?&nbsp; Any suggestions at all?&nbsp; Do you think it has something to do w/ the MMU of the
 PPC405, or am I way off base here?&nbsp; I know this isn't an FPGA forum, but then I don't think there exists a forum which exactly meets my needs. :)<br><br>Thanks much, --scott<br><br><br></div></body></html>
--0-2037383298-1153155158=:65987--
