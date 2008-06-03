Return-Path: <ludovic.desroches@gmail.com>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.158])
	by ozlabs.org (Postfix) with ESMTP id AC89BDE2A8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jun 2008 20:05:54 +1000 (EST)
Received: by po-out-1718.google.com with SMTP id y22so4323473pof.4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 03 Jun 2008 03:05:53 -0700 (PDT)
Message-ID: <388e90610806030305i1b2a7c32j9bdac3209f8c1993@mail.gmail.com>
Date: Tue, 3 Jun 2008 12:05:52 +0200
From: "Ludovic Desroches" <ludovic.desroches@gmail.com>
To: "A. Nolson" <alohanono@gmail.com>
Subject: Re: How accessing to my IP registers from Linux
In-Reply-To: <48450B7C.2010000@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3079_28295658.1212487552568"
References: <388e90610806030023x4a2c1077hfbabb49b95853bd0@mail.gmail.com>
	<48450B7C.2010000@gmail.com>
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

------=_Part_3079_28295658.1212487552568
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your answer, unfortunately it doesn't work. I'm doing this :

static unsigned int *virtual_base =3D 0;
static unsigned long mem_addr =3D 0x70001e00;
static unsigned long mem_size =3D 0x100;
static unsigned int reg3 =3D 0;

static int __init gpio_init(void) {

    printk("<1>gpio: init_module\n");
    if(check_mem_region(mem_addr,mem_size))
    {
        printk("gpio: memory already in use\n");
        return -EBUSY;
    }
    // request memory for the device
    request_mem_region(mem_addr,mem_size,"gpio");
    // remap
    virtual_base =3D ioremap_nocache(mem_addr,mem_size);
    printk("ioremap: Virtual Address %08x\n",(unsigned int)virtual_base);
    printk("Physical Address %08x\n",(unsigned
int)virt_to_phys(virtual_base));
    if( virtual_base=3D=3D0 )
    {
        printk("ioremap failed\n");
        return -EBUSY ;
    }
    else
    {
        reg3 =3D XIo_Out32(virtual_base);
        printk("Result of GPIO_DATA =3D %08x\n",reg3) ;
        reg3 =3D XIo_Out32(virtual_base+4);
        printk("Result of GPIO_TRI =3D %08x\n",reg3) ;

        printk("Xio_Out32\n");
        XIo_Out32(virtual_base, 0x00);
    }
    return 0;
}

the result is :

gpio: init_module
ioremap: Virtual Address c500ee00
Physical Address 0500ee00
Xio_Out32

The LEDs stay ON. I find strange having physical address different from the
physical adress I wanted to map. Can I have a problem with my MMU ? As othe=
r
devices are working, I am not sure it's the MMU for exemple during boot :
eth0: Xilinx 10/100 EMAC at 0x80400000 mapped to 0xC5020000, irq=3D1 and
Ethernet is working so the MMU seems to be ok.


Thanks

Ludovic Desroches


2008/6/3 A. Nolson <alohanono@gmail.com>:

> Hi,
>
> I have recently developed a similar driver for that. Your IO memory
> remapping should look like similar to this in your module_init:
>
> -------
>
>   if ( (lcd_remap_address =3D (u32) ioremap(LCD_BASE, LCD_END - LCD_BASE =
+1
> )) =3D=3D 0) {
>       printk(KERN_ERR "Couldn't ioremap memory at 0x%08lX\n",
>              (unsigned long) LCD_BASE);
>       return -EFAULT;         }
>     // Configure the IO as outputs
>   XIo_Out32(lcd_remap_address  + 0x4,0x00);
> -------
> /A
>
> Ludovic Desroches wrote:
>
>>
>> Hi,
>>
>>
>> I have put xilinx kernel on my board : a memec FX12 based on a Virtex 4
>> FX. Everything thing is OK, I have my serial console, Ethernet is also O=
K.
>>
>> I have to make some drivers. For example one for the LCD screen. It is m=
y
>> first driver so I want to try with something easier like LEDs. I know th=
ere
>> is a driver from Xilinx but I want to do it by myself. Moreover it is on=
ly a
>> file to adapt Xilinx standelone driver for Kernel.
>>
>>
>> I try to read and to write the registers of my GPIO IP which is working,=
 I
>> have made some tests in standelone. How accessing to these registers ?
>>
>> I have tried with this for example but without success :
>>
>>    ptr =3D ioremap_nocache(0x70001e00,0x00000004);
>>    printk("GPIO_DATA (readl): %u\n",readl(ptr));
>>
>>
>> readl, outl, ioread32 : same result.
>>
>>
>> Thanks
>>
>>
>> Best Regards
>>
>>
>> --
>> Ludovic Desroches
>> Ing=E9nieur ESIEE 2008
>> mobile : 06 19 21 02 08
>> http://www.odulo.net
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
>


--=20
Ludovic Desroches
Ing=E9nieur ESIEE 2008
mobile : 06 19 21 02 08
http://www.odulo.net

------=_Part_3079_28295658.1212487552568
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your answer, unfortunately it doesn&#39;t work. I&#39;m doing th=
is :<br><br>static unsigned int *virtual_base =3D 0;<br>static unsigned lon=
g mem_addr =3D 0x70001e00;<br>static unsigned long mem_size =3D 0x100;<br>s=
tatic unsigned int reg3 =3D 0;<br>
<br>static int __init gpio_init(void) {<br><br>&nbsp;&nbsp;&nbsp; printk(&q=
uot;&lt;1&gt;gpio: init_module\n&quot;);<br>&nbsp;&nbsp;&nbsp; if(check_mem=
_region(mem_addr,mem_size))<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; printk(&quot;gpio: memory already in use\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -EBUSY;<br>&nbsp;&nbsp;&nbsp; =
}<br>&nbsp;&nbsp;&nbsp; // request memory for the device<br>&nbsp;&nbsp;&nb=
sp; request_mem_region(mem_addr,mem_size,&quot;gpio&quot;);<br>&nbsp;&nbsp;=
&nbsp; // remap<br>&nbsp;&nbsp;&nbsp; virtual_base =3D ioremap_nocache(mem_=
addr,mem_size);<br>&nbsp;&nbsp;&nbsp; printk(&quot;ioremap: Virtual Address=
 %08x\n&quot;,(unsigned int)virtual_base);<br>
&nbsp;&nbsp;&nbsp; printk(&quot;Physical Address %08x\n&quot;,(unsigned int=
)virt_to_phys(virtual_base));<br>&nbsp;&nbsp;&nbsp; if( virtual_base=3D=3D0=
 )<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(=
&quot;ioremap failed\n&quot;);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret=
urn -EBUSY ;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg3 =3D=
 XIo_Out32(virtual_base);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(&=
quot;Result of GPIO_DATA =3D %08x\n&quot;,reg3) ;<br>&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; reg3 =3D XIo_Out32(virtual_base+4);<br>&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; printk(&quot;Result of GPIO_TRI =3D %08x\n&quot;,reg3) ;<=
br>
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(&quot;Xio_Out32\n&quot;);<=
br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; XIo_Out32(virtual_base, 0x00);<br>=
&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>the result=
 is : <br><br>gpio: init_module<br>ioremap: Virtual Address c500ee00<br>Phy=
sical Address 0500ee00<br>
Xio_Out32<br><br>The LEDs stay ON. I find strange having physical address d=
ifferent from the physical adress I wanted to map. Can I have a problem wit=
h my MMU ? As other devices are working, I am not sure it&#39;s the MMU for=
 exemple during boot : eth0: Xilinx 10/100 EMAC at 0x80400000 mapped to 0xC=
5020000, irq=3D1 and Ethernet is working so the MMU seems to be ok.<br>
<br><br>Thanks<br><br>Ludovic Desroches<br><br><br><div class=3D"gmail_quot=
e">2008/6/3 A. Nolson &lt;<a href=3D"mailto:alohanono@gmail.com">alohanono@=
gmail.com</a>&gt;:<br><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
Hi,<br>
<br>
I have recently developed a similar driver for that. Your IO memory remappi=
ng should look like similar to this in your module_init:<br>
<br>
-------<br>
<br>
 &nbsp; if ( (lcd_remap_address =3D (u32) ioremap(LCD_BASE, LCD_END - LCD_B=
ASE +1 )) =3D=3D 0) {<br>
 &nbsp; &nbsp; &nbsp; printk(KERN_ERR &quot;Couldn&#39;t ioremap memory at =
0x%08lX\n&quot;,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(unsigned long) LCD_BASE);=
<br>
 &nbsp; &nbsp; &nbsp; return -EFAULT; &nbsp; &nbsp; &nbsp;  &nbsp; }<br>
 &nbsp; &nbsp; // Configure the IO as outputs<br>
 &nbsp; XIo_Out32(lcd_remap_address &nbsp;+ 0x4,0x00); &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;<br>
------- <br>
/A<br>
<br>
Ludovic Desroches wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"Wj3C7c">
<br>
Hi,<br>
<br>
&nbsp;<br>
I have put xilinx kernel on my board : a memec FX12 based on a Virtex 4 FX.=
 Everything thing is OK, I have my serial console, Ethernet is also OK.<br>
<br>
I have to make some drivers. For example one for the LCD screen. It is my f=
irst driver so I want to try with something easier like LEDs. I know there =
is a driver from Xilinx but I want to do it by myself. Moreover it is only =
a file to adapt Xilinx standelone driver for Kernel.<br>

<br>
&nbsp;<br>
I try to read and to write the registers of my GPIO IP which is working, I =
have made some tests in standelone. How accessing to these registers ?<br>
<br>
I have tried with this for example but without success :<br>
<br>
 &nbsp; &nbsp;ptr =3D ioremap_nocache(0x70001e00,0x00000004);<br>
 &nbsp; &nbsp;printk(&quot;GPIO_DATA (readl): %u\n&quot;,readl(ptr));<br>
<br>
 &nbsp; &nbsp; <br>
readl, outl, ioread32 : same result.<br>
<br>
&nbsp;<br>
Thanks<br>
<br>
&nbsp;<br>
Best Regards<br>
<br>
<br>
-- <br>
Ludovic Desroches<br>
Ing=E9nieur ESIEE 2008<br>
mobile : 06 19 21 02 08<br>
<a href=3D"http://www.odulo.net" target=3D"_blank">http://www.odulo.net</a>=
<br></div></div>
------------------------------------------------------------------------<br=
>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=3D"_blank">Linuxppc-=
embedded@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target=3D=
"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
</blockquote>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ludovic Desroches<br>In=
g=E9nieur ESIEE 2008<br>mobile : 06 19 21 02 08<br><a href=3D"http://www.od=
ulo.net">http://www.odulo.net</a>

------=_Part_3079_28295658.1212487552568--
