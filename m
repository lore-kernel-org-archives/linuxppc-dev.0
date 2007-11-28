Return-Path: <dell.query@yahoo.com>
Received: from n7.bullet.ukl.yahoo.com (n7.bullet.ukl.yahoo.com
	[217.146.182.187]) by ozlabs.org (Postfix) with SMTP id A8D12DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 19:26:02 +1100 (EST)
Date: Tue, 27 Nov 2007 22:38:00 -0800 (PST)
From: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
To: Josh Boyer <jwboyer@gmail.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20071127212548.3efd39e9@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-750460071-1196231880=:2036"
Message-ID: <639733.2036.qm@web45601.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-750460071-1196231880=:2036
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Oh is it 0x1C0002000?

Where can I get the document? What I have is 0xC0002000 from ep440xc_um_amcc.pdf file that I get from the accompanying PPC440EPx resource CD.

Thanks!

dell

Josh Boyer <jwboyer@gmail.com> wrote: On Tue, 27 Nov 2007 02:47:45 -0800 (PST)
Dell Query  wrote:

> Hi,
> 
> I am creating a simple program which will try to read the board ID of the PPC440EPx thru BCSR but when I load it, it gives me "Data Read PLB Error". 
> 
> I am not sure if I missed out something.
> 
> I would really appreciate it if somebody could help me on this.
> 
> I have posted the source code below, as well as the complete message.
> 
> Many thanks!
> 
> SOURCE CODE:
> ----------------------------------------------------------------------
> #include 

> #include 

> #include 

> #include 

> #include 

> #include 

> #include 

> #include 
> #include 
> #include 

> #include 

> #include 
> #include 
> 
> MODULE_LICENSE("GPL");
> 
> #define BCSR_BASE   0xC0002000

This is wrong.  It's 0x1C0002000.

> #define BCSR0       0
> #define BCSR1       1
> #define BCSR2       2
> 
> #define USER_LED    0x2
> #define SIZE_TO_MAP 10
> 
> #define LED_ON      0
> 
> uint __iomem *bcsrbase = NULL;
> 
> static int __init initFunction(void) {
>    uint tmp;
>    printk("<1> Calling init function.\n");
>    printk("<1> bcsrbase value %p...\n",bcsrbase);
>    printk("<1> Remapping %x...\n",BCSR_BASE);
>    /*map*/
>    bcsrbase = ioremap(BCSR_BASE, SIZE_TO_MAP);

Since this seems to be arch/ppc, use ioremap64.

josh
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


       
---------------------------------
Never miss a thing.   Make Yahoo your homepage.
--0-750460071-1196231880=:2036
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Oh is it 0x1C0002000?<br><br>Where can I get the document? What I have is 0xC0002000 from ep440xc_um_amcc.pdf file that I get from the accompanying PPC440EPx resource CD.<br><br>Thanks!<br><br>dell<br><br><b><i>Josh Boyer &lt;jwboyer@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On Tue, 27 Nov 2007 02:47:45 -0800 (PST)<br>Dell Query <dell.query@yahoo.com> wrote:<br><br>&gt; Hi,<br>&gt; <br>&gt; I am creating a simple program which will try to read the board ID of the PPC440EPx thru BCSR but when I load it, it gives me "Data Read PLB Error". <br>&gt; <br>&gt; I am not sure if I missed out something.<br>&gt; <br>&gt; I would really appreciate it if somebody could help me on this.<br>&gt; <br>&gt; I have posted the source code below, as well as the complete message.<br>&gt; <br>&gt; Many thanks!<br>&gt; <br>&gt; SOURCE CODE:<br>&gt;
 ----------------------------------------------------------------------<br>&gt; #include <linux><br>&gt; #include <linux><br>&gt; #include <linux><br>&gt; #include <linux><br>&gt; #include <linux><br>&gt; #include <linux><br>&gt; #include <linux><br>&gt; #include <asm><br>&gt; #include <asm><br>&gt; #include <linux><br>&gt; #include <linux><br>&gt; #include <asm><br>&gt; #include <asm><br>&gt; <br>&gt; MODULE_LICENSE("GPL");<br>&gt; <br>&gt; #define BCSR_BASE   0xC0002000<br><br>This is wrong.  It's 0x1C0002000.<br><br>&gt; #define BCSR0       0<br>&gt; #define BCSR1       1<br>&gt; #define BCSR2       2<br>&gt; <br>&gt; #define USER_LED    0x2<br>&gt; #define SIZE_TO_MAP 10<br>&gt; <br>&gt; #define LED_ON      0<br>&gt; <br>&gt; uint __iomem *bcsrbase = NULL;<br>&gt; <br>&gt; static int __init initFunction(void) {<br>&gt;    uint tmp;<br>&gt;    printk("&lt;1&gt; Calling init function.\n");<br>&gt;    printk("&lt;1&gt; bcsrbase value %p...\n",bcsrbase);<br>&gt;   
 printk("&lt;1&gt; Remapping %x...\n",BCSR_BASE);<br>&gt;    /*map*/<br>&gt;    bcsrbase = ioremap(BCSR_BASE, SIZE_TO_MAP);<br><br>Since this seems to be arch/ppc, use ioremap64.<br><br>josh<br>_______________________________________________<br>Linuxppc-embedded mailing list<br>Linuxppc-embedded@ozlabs.org<br>https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br></asm></asm></linux></linux></asm></asm></linux></linux></linux></linux></linux></linux></linux></dell.query@yahoo.com></blockquote><br><p>&#32;



      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a>


--0-750460071-1196231880=:2036--
