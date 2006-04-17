Return-Path: <vwinstead@yahoo.com>
Received: from web52008.mail.yahoo.com (web52008.mail.yahoo.com
	[206.190.48.91]) by ozlabs.org (Postfix) with SMTP id 372F2679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 07:00:39 +1000 (EST)
Message-ID: <20060417210038.18561.qmail@web52008.mail.yahoo.com>
Date: Mon, 17 Apr 2006 14:00:38 -0700 (PDT)
From: Vincent Winstead <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
To: Aidan Williams <aidan@nicta.com.au>
In-Reply-To: <443D7AF5.6030401@nicta.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-444328156-1145307638=:6234"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-444328156-1145307638=:6234
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

  OK - I think i'm on a roll now.  I downloaded the necessary files for the uClinux distribution.  Two questions:
   
  1. I'm having a problem with two steps
          Step 5.  In your uClinux-dist directory, create a symbolic link called linux-2.4.x which points to the linuxppc-2.4 directory (linux-2.4.x -> ../linuxppc-2.4). 
          Step 6.  Ensure that you have the latest uClinux EDK Board Support Package installed (version 1.00d or later is required). 
   
  Now, as far as step 5, am I supposed to have a symbolic link that is named linux-2.4.x placed into the uClinux-dist directory?  Because there's already a folder named linux-2.4.x which was in there already when I untarred everything.  At the command prompt in the uClinux-dist directory I entered the following line:
   
  ln -s ../linuxppc-2.4 linux-2.4.x 
   
  and the result of this operation was to put a symbolic link into my linuxppc-2.4 directory with the name of linux-2.4.x  - is this correct?
   
  Now on to Step 6 problem.  
    How am I supposed to make use uClinux EDK Board Support Package 1.0 files?  I'm not sure how to go about using them in the Xilinx Platform Studio in order to generate the necessary auto-config.in file.  
   
  -Vincent
   
  
Aidan Williams <aidan@nicta.com.au> wrote:
  Grant Likely wrote:
> If you use 2.4: You need to use rsync to get the linuxppc-2.4 tree
> because I don't think anyone is maintaining .tar.gz of the rsync
> snapshot. Email Tom Rini and ask him. The linuxppc-2.4 tree is
> special because it's one of the trees that actually has the ML300
> patches integrated. Mainline does not.
> 

For 2.4, I've had good success on two different boards
using the v2pro and virtex4 parts with:

http://www.itee.uq.edu.au/~pml/uclinux_powerpc/

The kernel tarball there has support for various xilinx
supplied peripheral cores..

The neat thing about this approach is that there is a
uclinux BSP for the EDK that is used to generate an
auto-config.in file which you then drop directly
into the linux kernel tree.

Even though it is about the microblaze rather than
the PPC, a helpful "getting started" document is:
http://www.itee.uq.edu.au/~wu/downloads/uClinux_ready_Microblaze_design.pdf

- aidan



--0-444328156-1145307638=:6234
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>&nbsp; OK - I think i'm on a roll now.&nbsp; I downloaded the necessary files for the uClinux distribution.&nbsp; Two questions:</div>  <div>&nbsp;</div>  <div>1. I'm having a problem with two steps</div>  <div><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Step 5.&nbsp; In your uClinux-dist directory, create a symbolic link called linux-2.4.x&nbsp;which points to the linuxppc-2.4 directory (linux-2.4.x -&gt; ../linuxppc-2.4).</STRONG> </div>  <div><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Step 6.&nbsp; Ensure that you have the latest </STRONG><A href="http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/Downloads/platforms.html#bsp_package"><STRONG>uClinux EDK Board Support Package</STRONG></A><STRONG> installed (version 1.00d or later is required).</STRONG> </div>  <div>&nbsp;</div>  <div>Now, as far as step 5, am I supposed to have a symbolic link that is named linux-2.4.x placed into the uClinux-dist directory?&nbsp; Because there's already a folder
 named linux-2.4.x which was in there already when I untarred everything.&nbsp; At the command prompt in the uClinux-dist directory I entered the following line:</div>  <div>&nbsp;</div>  <div>ln -s ../linuxppc-2.4 linux-2.4.x </div>  <div>&nbsp;</div>  <div>and the result of this operation was to put a symbolic link into my linuxppc-2.4 directory with the name of linux-2.4.x&nbsp; - is this correct?</div>  <div>&nbsp;</div>  <div>Now on to Step 6 problem.&nbsp; </div>  <div>&nbsp; How am I supposed to make use uClinux EDK Board Support Package 1.0 files?&nbsp; I'm not sure how to go about using them in the Xilinx Platform Studio in order to generate the necessary auto-config.in file.&nbsp; </div>  <div>&nbsp;</div>  <div>-Vincent</div>  <div>&nbsp;</div>  <div><BR><B><I>Aidan Williams &lt;aidan@nicta.com.au&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Grant Likely wrote:<BR>&gt; If you use
 2.4: You need to use rsync to get the linuxppc-2.4 tree<BR>&gt; because I don't think anyone is maintaining .tar.gz of the rsync<BR>&gt; snapshot. Email Tom Rini and ask him. The linuxppc-2.4 tree is<BR>&gt; special because it's one of the trees that actually has the ML300<BR>&gt; patches integrated. Mainline does not.<BR>&gt; <BR><BR>For 2.4, I've had good success on two different boards<BR>using the v2pro and virtex4 parts with:<BR><BR>http://www.itee.uq.edu.au/~pml/uclinux_powerpc/<BR><BR>The kernel tarball there has support for various xilinx<BR>supplied peripheral cores..<BR><BR>The neat thing about this approach is that there is a<BR>uclinux BSP for the EDK that is used to generate an<BR>auto-config.in file which you then drop directly<BR>into the linux kernel tree.<BR><BR>Even though it is about the microblaze rather than<BR>the PPC, a helpful "getting started" document is:<BR>http://www.itee.uq.edu.au/~wu/downloads/uClinux_ready_Microblaze_design.pdf<BR><BR>-
 aidan<BR><BR></BLOCKQUOTE><BR>
--0-444328156-1145307638=:6234--
