Return-Path: <alohanono@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 4110CDE3CA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jun 2008 19:14:41 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so42988ugf.0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 03 Jun 2008 02:14:40 -0700 (PDT)
Message-ID: <48450B7C.2010000@gmail.com>
Date: Tue, 03 Jun 2008 11:14:36 +0200
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: Ludovic Desroches <ludovic.desroches@gmail.com>
Subject: Re: How accessing to my IP registers from Linux
References: <388e90610806030023x4a2c1077hfbabb49b95853bd0@mail.gmail.com>
In-Reply-To: <388e90610806030023x4a2c1077hfbabb49b95853bd0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

 I have recently developed a similar driver for that. Your IO memory 
remapping should look like similar to this in your module_init:

-------

    if ( (lcd_remap_address = (u32) ioremap(LCD_BASE, LCD_END - LCD_BASE 
+1 )) == 0) {
        printk(KERN_ERR "Couldn't ioremap memory at 0x%08lX\n",
               (unsigned long) LCD_BASE);
        return -EFAULT;       
    }
   
    // Configure the IO as outputs
    XIo_Out32(lcd_remap_address  + 0x4,0x00);          

------- 

 /A

Ludovic Desroches wrote:
>
> Hi,
>
>  
>
> I have put xilinx kernel on my board : a memec FX12 based on a Virtex 
> 4 FX. Everything thing is OK, I have my serial console, Ethernet is 
> also OK.
>
> I have to make some drivers. For example one for the LCD screen. It is 
> my first driver so I want to try with something easier like LEDs. I 
> know there is a driver from Xilinx but I want to do it by myself. 
> Moreover it is only a file to adapt Xilinx standelone driver for Kernel.
>
>  
>
> I try to read and to write the registers of my GPIO IP which is 
> working, I have made some tests in standelone. How accessing to these 
> registers ?
>
> I have tried with this for example but without success :
>
>     ptr = ioremap_nocache(0x70001e00,0x00000004);
>     printk("GPIO_DATA (readl): %u\n",readl(ptr));
>
>      
>
> readl, outl, ioread32 : same result.
>
>  
>
> Thanks
>
>  
>
> Best Regards
>
>
> -- 
> Ludovic Desroches
> Ingénieur ESIEE 2008
> mobile : 06 19 21 02 08
> http://www.odulo.net
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
