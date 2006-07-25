Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc12.comcast.net (sccrmhc12.comcast.net [204.127.200.82])
	by ozlabs.org (Postfix) with ESMTP id F420867B66
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 14:03:43 +1000 (EST)
Message-ID: <44C59818.5020207@dlasys.net>
Date: Tue, 25 Jul 2006 00:03:36 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: jagannathanjay@aim.com, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Reg. virtual address space in embedded linux
References: <8C87B6A995C6521-1C74-11273@FWM-M25.sysops.aol.com>
In-Reply-To: <8C87B6A995C6521-1C74-11273@FWM-M25.sysops.aol.com>
Content-Type: multipart/alternative;
	boundary="------------060101050409020401020809"
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060101050409020401020809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


    Is there a reason you need to map and unmap physical/virtual memory
every time you do a read or write ?

    I think the norm is to map the physical region in your device driver
in its initialization code and unmap it if the driver exits.

    After that you should be able to read and write your chip as you
wish. If the registers are RW then you should be able to "dump" them by
    reading them at whatever later time you choose.


jagannathanjay@aim.com wrote:
> Hi all
>
> We are porting third party driver code from vxworks to Embedded linux
> in MPC 8260 under a evaluation platform from Embedded Planet in linux
> kernel space.
>
> The first step we carried out was reading the chip id and we were able
> to read the chip id correctly.
>  
> For reading the chip id we used the routine ChipReadMemory in the
> attached text and we were able to retrive the chip id successfully.
>  
> Subsequently when we write and read from Chip Specific Control Status
> registers ,it didn't work.
>  
> I checked the manual and the Chip Specific Control Status registers
> have RW access.
>  
> Any inputs on how to check if the write we made to virtual address
> succeeds?
>  
> Is there a way to dump the linux virtual address and examine the write
> we made ?
>
> Regards
> Jay
>
>  
> ------------------------------------------------------------------------
> *Check Out the new free AIM(R) Mail*
> <http://pr.atwola.com/promoclk/100122638x1081283466x1074645346/aol?redir=http%3A%2F%2Fwww%2Eaim%2Ecom%2Ffun%2Fmail%2F>
> -- 2 GB of storage and industry-leading spam and email virus protection.
> ------------------------------------------------------------------------
>
> int ChipReadMemory(unsigned int arg_phys_addr,unsigned int *memValue)
> {
>   void  *virt_addr = NULL;
>   unsigned int phys_addr = 0;
>
>   phys_addr =  DEVICE_BASE_ADDRESS + arg_phys_addr;
>   virt_addr = ioremap(phys_addr, 4);
>   if(virt_addr == NULL)
>   {
>      printk("ChipReadMemory: unable to perform ioremap \n");
>      return -1;
>   }
>   *memValue  = readl(virt_addr);
>     iounmap(virt_addr);
>     return 0;
> }
>
>
> int ChipWriteMemory(unsigned int arg_phys_addr, unsigned int arg_val)
> {
>   void  *virt_addr = NULL;
>   unsigned int phys_addr = 0;
>   phys_addr =  DEVICE_BASE_ADDRESS + arg_phys_addr;
>   virt_addr = ioremap(phys_addr, 4);
>   if(virt_addr == NULL)
>   {
>      printk("ChipWriteMemory : unable to perform ioremap \n");
>      return -1;
>   }
>   writel(arg_val,virt_addr);
>   iounmap(virt_addr);
>    return 0;
> }
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------060101050409020401020809
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
&nbsp;&nbsp;&nbsp; Is there a reason you need to map and unmap physical/virtual memory
every time you do a read or write ?<br>
<br>
&nbsp;&nbsp;&nbsp; I think the norm is to map the physical region in your device
driver in its initialization code and unmap it if the driver exits.<br>
<br>
&nbsp;&nbsp;&nbsp; After that you should be able to read and write your chip as you
wish. If the registers are RW then you should be able to "dump" them by
<br>
&nbsp;&nbsp;&nbsp; reading them at whatever later time you choose.<br>
<br>
<br>
<a class="moz-txt-link-abbreviated" href="mailto:jagannathanjay@aim.com">jagannathanjay@aim.com</a>
wrote:
<blockquote cite="mid8C87B6A995C6521-1C74-11273@FWM-M25.sysops.aol.com"
 type="cite">
  <div>Hi all<br>
  <div><span class="406521009-18072006"><font face="Tahoma" size="2"><br>
We are porting third party driver code from vxworks to Embedded linux
in MPC 8260 under a evaluation platform from Embedded Planet in linux
kernel space.<br>
  <br>
  </font></span>
  <div><span class="406521009-18072006"><font face="Tahoma" size="2">The
first step we carried out was reading the chip id and we were able to
read the chip id correctly.</font></span></div>
  <div><span class="406521009-18072006"></span>&nbsp;</div>
  <div><span class="406521009-18072006"><font face="Tahoma" size="2">For
reading the chip id we used the routine ChipReadMemory in the attached
text&nbsp;and we were able to retrive the chip id successfully.</font></span></div>
  <div><span class="406521009-18072006"></span>&nbsp;</div>
  <div><span class="406521009-18072006"><font face="Tahoma" size="2">Subsequently
when we write and read from&nbsp;Chip Specific Control Status registers ,it
didn't work.</font></span></div>
  <div><span class="406521009-18072006"></span>&nbsp;</div>
  <div><span class="406521009-18072006"><font face="Tahoma" size="2">I
checked the manual and the Chip Specific Control Status registers have
RW access.</font></span></div>
  <div><span class="406521009-18072006"></span>&nbsp;</div>
  <div><span class="406521009-18072006"><font face="Tahoma" size="2">Any
inputs on how to check if the write we made to virtual address succeeds?</font></span></div>
  <div><span class="406521009-18072006"></span>&nbsp;</div>
  <div><span class="406521009-18072006"><font face="Tahoma" size="2">Is
there a way to dump the linux virtual address and examine&nbsp;the write we
made&nbsp;?<br>
  <br>
Regards<br>
Jay<br>
  </font></span></div>
  <br>
  </div>
&nbsp;</div>
  <div class="AOLPromoFooter">
  <hr style="margin-top: 10px;"><a
 href="http://pr.atwola.com/promoclk/100122638x1081283466x1074645346/aol?redir=http%3A%2F%2Fwww%2Eaim%2Ecom%2Ffun%2Fmail%2F"
 target="_blank"><b>Check Out the new free AIM(R) Mail</b></a> -- 2 GB
of storage and industry-leading spam and email virus protection.<br>
  </div>
  <pre wrap=""><hr size="4" width="90%">
int ChipReadMemory(unsigned int arg_phys_addr,unsigned int *memValue)
{
  void  *virt_addr = NULL;
  unsigned int phys_addr = 0;

  phys_addr =  DEVICE_BASE_ADDRESS + arg_phys_addr;
  virt_addr = ioremap(phys_addr, 4);
  if(virt_addr == NULL)
  {
     printk("ChipReadMemory: unable to perform ioremap \n");
     return -1;
  }
  *memValue  = readl(virt_addr);
    iounmap(virt_addr);
    return 0;
}


int ChipWriteMemory(unsigned int arg_phys_addr, unsigned int arg_val)
{
  void  *virt_addr = NULL;
  unsigned int phys_addr = 0;
  phys_addr =  DEVICE_BASE_ADDRESS + arg_phys_addr;
  virt_addr = ioremap(phys_addr, 4);
  if(virt_addr == NULL)
  {
     printk("ChipWriteMemory : unable to perform ioremap \n");
     return -1;
  }
  writel(arg_val,virt_addr);
  iounmap(virt_addr);
   return 0;
}
  </pre>
  <pre wrap=""><hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated"
 href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext"
 href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated"
 href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a
 class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------060101050409020401020809--
