Return-Path: <aish_bhaskaran@yahoo.co.in>
Received: from web94510.mail.in2.yahoo.com (web94510.mail.in2.yahoo.com
	[203.104.16.250]) by ozlabs.org (Postfix) with SMTP id CF7E7DDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 03:31:09 +1000 (EST)
Message-ID: <20070404172428.13330.qmail@web94510.mail.in2.yahoo.com>
Date: Wed, 4 Apr 2007 18:24:28 +0100 (BST)
From: aishwarya bhas <aish_bhaskaran@yahoo.co.in>
Subject: Accessing the Host Memory (x86) by the Agent (MPC 8540)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-283358712-1175707468=:13050"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-283358712-1175707468=:13050
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi....
  
   We are using linux kernel 2.6.9. x86 acts as the host and MPC8540  is placed in the PCI slot of the host.MPC8540 is configured in agent  mode and it runs on u-boot.The uboot version that we are using is  u-boot-1.1.2.
  
  The steps that we followed to accomplish the above task is as follows:-
  
  1.)Allocated memory in the host (x86), using kmalloc and returned the ptrdata....
  
  //Allocating 20 K of memory in the Host RAM
  
    ptrdata = (unsigned volatile long *) kmalloc( 20 * 1024 , GFP_KERNEL);
  
  
  2.)We write to pci outbound registers, so that the MPC8540 could access the
    
   host memory......
  
  
  (a)pci translation register (b)pci base register (c) pci attribute register.
  
  
  We converted this virtual address to PCI Bus address... using virt_to_bus() function..     
  
    ulTemp  = ( unsigned volatile long  ) virt_to_bus ( void * ) ptrdata);
   
  // To Mask the lower 12 bits for translation address
  
     ulTemp =  swap(ulTemp >> 12) ;
  
   //Outbound Translation Register
  
      writel(ulTemp,  (unsigned long)ioaddr+ 0x8C20);
  
    //ioaddr is address that we got after remapping  ioaddr = ioremap_nocache((pio_start), pio_len);
  
   //Outbound Base Address Register
   
     writel((swap(0xE0000000 >> 12)) ,  (unsigned long)ioaddr+ 0x8C28);
  
   //Outbound Attribute Register
  
      writel(swap(0x8004401A),  (unsigned long)ioaddr+ 0x8C30);
  
      We also tried with the Attribute Register value 0x8005501C...
   
      We also used the function wmb() after writing to the  outbound registers, since it guarantees ordering in write operations..
      
      After this we wrote some value in the ptrdata(i.e in the virtual address),for testing .
  
  3.)We used the minicom to check whether we are able to access the host memory from the agent by doing md 0xE000_0000
  
   i.e to find whether we were able to get the value which we wrote  in the ptrdata(ie. in the virtual address got from kmalloc) ....( Also  not sure if this is the way we have to do.....) . But we are getting  all values as zeroes.
  
  4.) We checked in Bus Command Register, whether the Bus master and Memory is  enabled....
  
      This is the Configuration Register value :
  
  Algs: bus master, 66Mhz, fast devsel, latency 64
          Memory at dee00000 (32-bit, non-prefetchable) [size=1M]
          [virtual] Memory at dedf0000 (32-bit, non-prefetchable) [size=64K]
          Capabilities: [60] #00 [0000]
  00: 57 10 08 00 46 01 b0 20 20 01 20 0b 00 40 00 00
  10: 00 00 e0 de 00 00 00 00 00 00 00 00 00 00 00 00
  20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
  40: 00 00 00 00 09 00 00 80 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  
   We aren't sure of whether, we have to write to the physical address or to the
  Virtual address ofthe host RAM i.e x86 by configuring these outbound
  Registers......
  
  Cud anybody solve our problem. tell us if we are missing anything,any step.Please respond to our request.It is urgent.
  
  
  Thanks 
  Aishwariya
 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-283358712-1175707468=:13050
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi....<br>  <br>  &nbsp;We are using linux kernel 2.6.9. x86 acts as the host and MPC8540  is placed in the PCI slot of the host.MPC8540 is configured in agent  mode and it runs on u-boot.The uboot version that we are using is  u-boot-1.1.2.<br>  <br>  The steps that we followed to accomplish the above task is as follows:-<br>  <br>  1.)Allocated memory in the host (x86), using kmalloc and returned the ptrdata....<br>  <br>  //Allocating 20 K of memory in the Host RAM<br>  <br>  &nbsp; ptrdata = (unsigned volatile long *) kmalloc( 20 * 1024 , GFP_KERNEL);<br>  <br>  <br>  2.)We write to pci outbound registers, so that the MPC8540 could access the<br>  &nbsp; <br>  &nbsp;host memory......<br>  <br>  <br>  (a)pci translation register (b)pci base register (c) pci attribute register.<br>  <br>  <br>  We converted this virtual address to PCI Bus address... using virt_to_bus() function..&nbsp;&nbsp; &nbsp; <br>  <br>  &nbsp; ulTemp&nbsp; = ( unsigned volatile long&nbsp; )
 virt_to_bus ( void * ) ptrdata);<br>  &nbsp;<br>  // To Mask the lower 12 bits for translation address<br>  <br>  &nbsp;&nbsp; ulTemp =&nbsp; swap(ulTemp &gt;&gt; 12) ;<br>  <br>  &nbsp;//Outbound Translation Register<br>  <br>  &nbsp;&nbsp;&nbsp; writel(ulTemp,&nbsp; (unsigned long)ioaddr+ 0x8C20);<br>  <br>  &nbsp; //ioaddr is address that we got after remapping&nbsp; ioaddr = ioremap_nocache((pio_start), pio_len);<br>  <br>  &nbsp;//Outbound Base Address Register<br>  &nbsp;<br>  &nbsp;&nbsp; writel((swap(0xE0000000 &gt;&gt; 12)) ,&nbsp; (unsigned long)ioaddr+ 0x8C28);<br>  <br>  &nbsp;//Outbound Attribute Register<br>  <br>  &nbsp;&nbsp;&nbsp; writel(swap(0x8004401A),&nbsp; (unsigned long)ioaddr+ 0x8C30);<br>  <br>  &nbsp;&nbsp;&nbsp; We also tried with the Attribute Register value 0x8005501C...<br>  &nbsp;<br>  &nbsp;&nbsp;&nbsp; We also used the function wmb() after writing to the  outbound registers, since it guarantees ordering in write operations..<br> 
 &nbsp;&nbsp; &nbsp;<br>  &nbsp;&nbsp;&nbsp; After this we wrote some value in the ptrdata(i.e in the virtual address),for testing .<br>  <br>  3.)We used the minicom to check whether we are able to access the host memory from the agent by doing md 0xE000_0000<br>  <br>  &nbsp;i.e to find whether we were able to get the value which we wrote  in the ptrdata(ie. in the virtual address got from kmalloc) ....( Also  not sure if this is the way we have to do.....) . But we are getting  all values as zeroes.<br>  <br>  4.) We checked in Bus Command Register, whether the Bus master and Memory is&nbsp; enabled....<br>  <br>  &nbsp;&nbsp;&nbsp; This is the Configuration Register value :<br>  <br>  Algs: bus master, 66Mhz, fast devsel, latency 64<br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at dee00000 (32-bit, non-prefetchable) [size=1M]<br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [virtual] Memory at dedf0000 (32-bit, non-prefetchable) [size=64K]<br> 
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [60] #00 [0000]<br>  00: 57 10 08 00 46 01 b0 20 20 01 20 0b 00 40 00 00<br>  10: 00 00 e0 de 00 00 00 00 00 00 00 00 00 00 00 00<br>  20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00<br>  40: 00 00 00 00 09 00 00 80 00 00 00 00 00 00 00 00<br>  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 00<br>  <br>  &nbsp;We aren't sure of whether, we have to write to the physical address or to the<br>  Virtual address ofthe host RAM i.e x86 by configuring these outbound<br>  Registers......<br>  <br>  Cud anybody solve our problem. tell us if we are missing anything,any step.Please respond to our request.It is urgent.<br>  <br>  <br>  Thanks <br>  Aishwariya<p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-283358712-1175707468=:13050--
