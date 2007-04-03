Return-Path: <ice2006_blue@yahoo.com>
Received: from web51910.mail.re2.yahoo.com (web51910.mail.re2.yahoo.com
	[206.190.48.73]) by ozlabs.org (Postfix) with SMTP id 17BA0DDF41
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 00:07:12 +1000 (EST)
Date: Tue, 3 Apr 2007 07:00:32 -0700 (PDT)
From: eyes bh <ice2006_blue@yahoo.com>
Subject: To access the host (x86) memory by the agent (mpc8540)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1886931800-1175608832=:57535"
Message-ID: <372014.57535.qm@web51910.mail.re2.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1886931800-1175608832=:57535
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi...
  
  We are using linux kernel 2.6.9 and mpc8540 as a network card in the host x86.mpc8540 acts as a agent and runs on u-boot.
  
  The steps that we followed to accomplish the above task is as follows:-
  
  1.)Allocated memory using kmalloc and returned the ptrdata....
  
    ptrdata = (unsigned long *) kmalloc( sizeof (unsigned long) , GFP_KERNEL);
  
  2.)We write to pci outbound registers......
  
  (a)pci translation register (b)pci base register (c) pci attribute register.
  
    ulTemp  = ( unsigned volatile long  ) virt_to_bus( ( void * ) ptrdata);
    ulTemp =  swap(ulTemp >> 12) ;
  
   //Outbound Translatiom Register
  
    writel(ulTemp,  (unsigned long)ioaddr+ 0x8C20);
      
  //ioaddr is address that we got after remapping  
  ioaddr = ioremap_nocache((pio_start), pio_len);
  
  //Outbound Base Address Register
  
      writel((swap(0xE0000000 >> 12)) ,  (unsigned long)ioaddr+ 0x8C28);
  
   //Outbound Attribute Register
  
      writel(swap(0x8005501C),  (unsigned long)ioaddr+ 0x8C30);
  
  3.)We used the minicom to check whether we are able to access the host  memory from the agent by doing md 0xE000_0000.But we are getting all  values as zeroes.
  
  Cud anybody solve our problem. tell us if we are missing anything,any step.Please respond to our request.It is urgent.
  
  Thanks
  Aishwariya
  
  
 
---------------------------------
Expecting? Get great news right away with email Auto-Check.
Try the Yahoo! Mail Beta.
--0-1886931800-1175608832=:57535
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi...<br>  <br>  We are using linux kernel 2.6.9 and mpc8540 as a network card in the host x86.mpc8540 acts as a agent and runs on u-boot.<br>  <br>  The steps that we followed to accomplish the above task is as follows:-<br>  <br>  1.)Allocated memory using kmalloc and returned the ptrdata....<br>  <br>  &nbsp; ptrdata = (unsigned long *) kmalloc( sizeof (unsigned long) , GFP_KERNEL);<br>  <br>  2.)We write to pci outbound registers......<br>  <br>  (a)pci translation register (b)pci base register (c) pci attribute register.<br>  <br>  &nbsp; ulTemp&nbsp; = ( unsigned volatile long&nbsp; ) virt_to_bus( ( void * ) ptrdata);<br>  &nbsp; ulTemp =&nbsp; swap(ulTemp &gt;&gt; 12) ;<br>  <br>  &nbsp;//Outbound Translatiom Register<br>  <br>  &nbsp; writel(ulTemp,&nbsp; (unsigned long)ioaddr+ 0x8C20);<br>  &nbsp;&nbsp;&nbsp; <br>  //ioaddr is address that we got after remapping&nbsp; <br>  ioaddr = ioremap_nocache((pio_start), pio_len);<br>  <br>  //Outbound Base Address
 Register<br>  <br>  &nbsp;&nbsp;&nbsp; writel((swap(0xE0000000 &gt;&gt; 12)) ,&nbsp; (unsigned long)ioaddr+ 0x8C28);<br>  <br>  &nbsp;//Outbound Attribute Register<br>  <br>  &nbsp;&nbsp;&nbsp; writel(swap(0x8005501C),&nbsp; (unsigned long)ioaddr+ 0x8C30);<br>  <br>  3.)We used the minicom to check whether we are able to access the host  memory from the agent by doing md 0xE000_0000.But we are getting all  values as zeroes.<br>  <br>  Cud anybody solve our problem. tell us if we are missing anything,any step.Please respond to our request.It is urgent.<br>  <br>  Thanks<br>  Aishwariya<br>  <br>  <p>&#32;

<hr size=1>Expecting? Get great news right away with <a href="http://us.rd.yahoo.com/evt=49982/*http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html">email Auto-Check.</a><br>Try the <a href="http://us.rd.yahoo.com/evt=49982/*http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html">Yahoo! Mail Beta.</a>
--0-1886931800-1175608832=:57535--
