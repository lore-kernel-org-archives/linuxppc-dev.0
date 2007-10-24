Return-Path: <afarajian@sinamicro.com>
Received: from forward.hsphere.cc (forward-dummy6.hsphere.cc [216.157.144.6])
	by ozlabs.org (Postfix) with SMTP id B3D66DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 23:07:00 +1000 (EST)
Content-Type: text/html; charset="iso-8859-1"
MIME-Version: 1.0
From: Amin Farajian <afarajian@sinamicro.com>
To: linuxppc-embedded@ozlabs.org
Subject: strataflash size and partitioning problem
Date: Wed, 24 Oct 2007 09:00:08 -0400
Message-Id: <20071024130700.B3D66DDDF4@ozlabs.org>
Reply-To: afarajian@sinamicro.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<p><br />Hi there,</p><p>We are working on an embedded platform which has 2=
56MB DDR and 64MB strataflash(<span>TE28F64J3C-120</span>) and&nbsp; our da=
tabus is 32 bits.&nbsp;</p><p>we have used the following MAP driver for our=
 strata flash as the start of our work:</p><p>-----------------------------=
-------------&nbsp;</p><p><p>#include &lt;linux/module.h&gt;<br />#include =
&lt;linux/types.h&gt;<br />#include &lt;linux/kernel.h&gt;<br />#include &l=
t;asm/io.h&gt;<br />#include &lt;linux/mtd/mtd.h&gt;<br />#include &lt;linu=
x/mtd/map.h&gt;<br />#include &lt;linux/mtd/partitions.h&gt;<br />#include =
&lt;linux/delay.h&gt;<br /></p></p><p><p>struct map_info sdp_map =3D<br />{=
<br />&nbsp;&nbsp;&nbsp; .name=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;SDP Flash&quot;,<br />&nbsp;&nbsp;&nbsp; .size=3D&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 8 * 1024 * 1024, /* Overwritten by cfi_probe */<br />&nbsp;&nbs=
p;&nbsp; .bankwidth=3D&nbsp;&nbsp; 2,<br />&nbsp;&nbsp;&nbsp; .phys=3DNO_XI=
P&nbsp;&nbsp;&nbsp; <br /><br />&nbsp;&nbsp;&nbsp; /*<br />&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; read:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_read,<br />&n=
bsp;&nbsp;&nbsp; write:&nbsp;&nbsp;&nbsp;&nbsp; sdp_write,<br />&nbsp;&nbsp=
;&nbsp; copy_from:&nbsp; sdp_copy_from,<br />&nbsp;&nbsp;&nbsp; */&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; <br />};<br /><br />static struct mtd_partition sdp_f=
lash_partition[] =3D<br />{<br />&nbsp;&nbsp;&nbsp; /*<br />&nbsp;&nbsp;&nb=
sp; &nbsp;* Flash map in the <br />&nbsp;&nbsp;&nbsp; &nbsp;*&nbsp;&nbsp;&n=
bsp; KERNEL AND BOOTLOADER AND ROOT : 20000000-24000000<br />&nbsp;&nbsp;&n=
bsp; */<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp; name:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;data&quot;,<br />&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 0x80=
0000,<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset:&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp;&nbsp; 0x00000000<br />&nbsp;&nbsp;&nbsp; },<br />};=
<br />static struct mtd_partition *sdp_partitions;<br />#define NB_OF(x)&nb=
sp;&nbsp;&nbsp; (sizeof(x)/sizeof(x[0]))<br />static struct mtd_info&nbsp;&=
nbsp;&nbsp; *mymtds;<br />static int __init sdp_init_mtd (void)<br />{<br /=
>&nbsp;&nbsp;&nbsp; <br />&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; nb_parts;<br />&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *part_type =3D &quot;static&quot;;<br />&nbsp;&nbsp;&=
nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i;<br />&nbsp;&nbsp;=
&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; flash_addresses =3D 0x20000000;<br />&nbsp;<br />&nbsp;&nbsp;&nb=
sp; /* Determine flash partitioning */<br />&nbsp;&nbsp;&nbsp; sdp_partitio=
ns =3D sdp_flash_partition;<br />&nbsp;&nbsp;&nbsp; nb_parts =3D NB_OF(sdp_=
flash_partition);<br />&nbsp;&nbsp;&nbsp; sdp_map.virt =3D ioremap (flash_a=
ddresses, sdp_map.size);<br />&nbsp;&nbsp;&nbsp; mymtds =3D do_map_probe(&q=
uot;cfi_probe&quot;, &amp;sdp_map);<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (!mymtds){<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iounmap ((void *) sdp_map.map_p=
riv_1);<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENXIO;<br />&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br /><br />&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; printk (KERN_NOTICE &quot;SDP flash device: %08xMB at=
 0x%08x\n&quot;,<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mymtds-&gt;size), flash_addresses);<=
br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_map.size =3D mymt=
ds-&gt;size;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mymtds-&gt;own=
er =3D THIS_MODULE;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk =
(KERN_NOTICE &quot;Using %s partition definition\n&quot;, part_type);<br />=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_mtd_partitions (mymtds, sdp_=
partitions, nb_parts);<br />&nbsp; &nbsp;&nbsp; &nbsp; return 0;<br />}<br =
/><br />static void __exit sdp_cleanup_mtd(void)<br />{<br />&nbsp;&nbsp;&n=
bsp; printk(&quot;sdp_cleanup_mtd\n&quot;);<br />&nbsp;&nbsp;&nbsp; return;=
<br />}<br /><br />module_init(sdp_init_mtd);<br />module_exit(sdp_cleanup_=
mtd); <br /></p></p><p>-----------------------------------------------<br /=
> =0D
</p><p>But unfortunately we were not able to map upper than 8MB of flash , =
and we found that the problem was related the range of Virtual address mapp=
ing in kernel. &nbsp;</p><p>So, </p><p>&nbsp;&nbsp;&nbsp; 1- What we can do=
 now if we want to map all of flash?</p><p>&nbsp;&nbsp;&nbsp; 2- Does it re=
late to bankwidth parameter in map_info structure? ( if we set that to 1 ,4=
, and the system will hangup..So what is that parameter?is it related to fl=
ash itself or data bandwidth or number of flashes on the board?)</p><p>&nbs=
p;</p><p>Any help will be greatly appretiated.&nbsp;</p><p>&nbsp;</p><BR>=
