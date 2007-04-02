Return-Path: <aish_bhaskaran@yahoo.co.in>
Received: from web94509.mail.in2.yahoo.com (web94509.mail.in2.yahoo.com
	[203.104.16.249]) by ozlabs.org (Postfix) with SMTP id 2CA12DDE47
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 03:17:08 +1000 (EST)
Message-ID: <20070402171026.77652.qmail@web94509.mail.in2.yahoo.com>
Date: Mon, 2 Apr 2007 18:10:26 +0100 (BST)
From: aishwarya bhas <aish_bhaskaran@yahoo.co.in>
Subject: To access the host (x86) memory by the agent (mpc8540)
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1788609921-1175533826=:77313"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1788609921-1175533826=:77313
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi...


We need to design a network driver..We are using linux kernel 2.6.9 and 
mpc8540 as a network card in the host x86.mpc8540 acts as a agent and runs on u-boot.

The steps that we followed to accomplish the above task is as follows:-

1.)Allocated memory using kmalloc and returned the ptrdata....

  ptrdata = (unsigned long *) kmalloc(sizeof(unsigned long , 
GFP_KERNEL);


2.)We write to pci outbound registers......
(a)pci translation register (b)pci base register (c) pci attribute 
register.

// Converting the virtual address got using kmalloc to PCI Bus address

ulTemp  = ( unsigned long  ) virt_to_bus( ( void * ) 
ptrdata);

ulTemp =  swap(ulTemp >> 12) ;

 //Outbound Translatiom Register

writel(ulTemp,(unsigned long)ioaddr+ 0x8C20);    
//ioaddr is address that we got after remapping  ioaddr = ioremap_nocache((pio_start), 
pio_len);

//Outbound Base Address Register
    writel((swap(0xE0000000 >> 12)) ,  (unsigned long)ioaddr+ 0x8C28);

 //Outbound Attribute Register
    writel(swap(0x8004401A),  (unsigned long)ioaddr+ 0x8C30);

3.)We used the minicom to check whether we are able to access the host 
memory from the agent by doing md 0xe0000000.But we are getting all 
values as zeroes.

Cud anybody solve our problem. tell us if we are missing anything,any 
step.Please respond to our request.It is urgent.

Thanks in advance,

Aishwariya

  
 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-1788609921-1175533826=:77313
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<pre><tt>Hi...<br><br><br></tt><tt></tt><tt>We need to design a network driver..We are using linux kernel 2.6.9 and <br>mpc8540 as a network card in the host x86.mpc8540 acts as a agent and runs on u-boot.<br><br>The steps that we followed to accomplish the above task is as follows:-<br><br>1.)Allocated memory using kmalloc and returned the ptrdata....<br><br>  ptrdata = (unsigned long *) kmalloc(sizeof(unsigned long , <br>GFP_KERNEL);<br><br><br>2.)We write to pci outbound registers......<br>(a)pci translation register (b)pci base register (c) pci attribute <br>register.<br><br>// Converting the virtual address got using kmalloc to PCI Bus address<br><br>ulTemp  = ( unsigned long  ) virt_to_bus( ( void * ) <br>ptrdata);<br><br>ulTemp =  swap(ulTemp &gt;&gt; 12) ;<br><br> //Outbound Translatiom Register<br><br>writel(ulTemp,(unsigned long)ioaddr+ 0x8C20);    <br>//ioaddr is address that we got after remapping  ioaddr = ioremap_nocache((pio_start),
 <br>pio_len);<br><br>//Outbound Base Address Register<br>    writel((swap(0xE0000000 &gt;&gt; 12)) ,  (unsigned long)ioaddr+ 0x8C28);<br><br> //Outbound Attribute Register<br>    writel(swap(0x8004401A),  (unsigned long)ioaddr+ 0x8C30);<br><br>3.)We used the minicom to check whether we are able to access the host <br>memory from the agent by doing md 0xe0000000.But we are getting all <br>values as zeroes.<br><br>Cud anybody solve our problem. tell us if we are missing anything,any <br>step.Please respond to our request.It is urgent.<br><br>Thanks in advance,<br><br>Aishwariya<br></tt></pre>  <p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-1788609921-1175533826=:77313--
