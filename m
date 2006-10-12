Return-Path: <mjoshi_blr@yahoo.com>
Received: from web34703.mail.mud.yahoo.com (web34703.mail.mud.yahoo.com
	[209.191.68.152]) by ozlabs.org (Postfix) with SMTP id 1AF6E67BEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 03:39:12 +1000 (EST)
Message-ID: <20061012173231.56756.qmail@web34703.mail.mud.yahoo.com>
Date: Thu, 12 Oct 2006 10:32:31 -0700 (PDT)
From: Manish Joshi <mjoshi_blr@yahoo.com>
Subject: Re: Problems with DMA from user space on MPC834x (Cache coherency?)
To: Lauri Ehrenpreis <lauri.ehrenpreis@liewenthal.ee>,
	linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1973371712-1160674351=:56748"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1973371712-1160674351=:56748
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Yeah it looks like a cache coherency problem from the first look.=0AYou may=
 try enabling snooping on the DMA channel if MPC824X supports it. Check in =
Mode register setting.=0AElse you may want to use flush_dcache_range(start,=
 last) functions and see if it helps.=0A =0A----- Original Message ----=0AF=
rom: Lauri Ehrenpreis <lauri.ehrenpreis@liewenthal.ee>=0ATo: linuxppc-embed=
ded@ozlabs.org=0ASent: Wednesday, October 11, 2006 7:20:03 AM=0ASubject: Pr=
oblems with DMA from user space on MPC834x (Cache coherency?)=0A=0A=0AHi!=
=0A=0AI have a problem with DMA from user space on a platform powered by MP=
C834x=0Aprocessor (which has powerpc e300 core inside). Our linux kernel ve=
rsion is=0A2.6.17.=0A=0AMy user space program does something like this:=0A=
=0Afile_fd =3D open("/disk/file", O_RDONLY);=0Aresult =3D read(file_fd, pag=
e_aligned_buf, len);=0Acall_driver_ioctl_which_performs_dma();=0A=0Awhile /=
disk is mounted to a partition residing on USB memory stick or SD=0Acard.=
=0Apage_aligned_buf starts from page boundary and contains enough full page=
s=0Afor=0Athe data (so I can allways map full page with dma_map_page in ker=
nel).=0A=0AThe buffer address and data length will then be passed to a driv=
er, which=0Acalls=0Aget_user_pages, then maps each page with dma_map_page a=
nd tells a PCI=0Adevice=0Ato start reading from that page:=0A=0A...=0Adown_=
read(&current->mm->mmap_sem);=0Aresult =3D get_user_pages(current, current-=
>mm, page_aligned_buf, nr_pages,=0A0, 0, pages, NULL);=0Aup_read(&current->=
mm->mmap_sem);=0A=0Afor (i =3D 0; i < nr_pages; i++) {=0A    find_data_chec=
ksum(pages[i]);=0A    dma_addr =3D dma_map_page(&fpga.pci_dev->dev, pages[i=
], 0, PAGE_SIZE,=0ADMA_TO_DEVICE);=0A=0A    start_dma();=0A=0A    wait_unti=
l_dma_ready();=0A=0A    dma_unmap_page(&fpga.pci_dev->dev, dma_addr, dma_le=
n, DMA_TO_DEVICE);=0A=0A    if(!checksum_ok_in_fpga())=0A        print_page=
_data();=0A}=0A=0Afor (i =3D 0; i < nr_pages; i++)=0A    page_cache_release=
(pages[i]);=0A=0AThe problem is that sometimes the PCI device receives wron=
g bytes at random=0Alocations. I find the data checksum inside the driver a=
nd inside the FPGA.=0AInside the driver I use kmap(page) and kunmap(page) t=
o access data on the=0Auser page. Sometimes the checksums do not match and =
I can see with the FPGA=0Adebugging tool, that the FPGA receives different =
data than the driver is=0Aprinting out.=0A=0AI have noticed 3 things regard=
ing this error:=0A1) When I copy the data I read from the block device to a=
nother buffer in=0Auserspace and pass this new buffer to the driver, then t=
his error will=0Anever occur:=0A=0Afile_fd =3D open("/disk/file", O_RDONLY)=
;=0Aresult =3D read(file_fd, page_aligned_buf, len);=0Amemcpy(new_page_alig=
ned_buf, page_aligned_buf, len);=0Acall_driver_ioctl_which_performs_dma(new=
_page_aligned_buf, len);=0A=0A2) this error does not occur when I use copy_=
from_user instead of=0Aget_user_pages=0Aand dma_map_page inside driver.=0A=
=0A3) this error does not occur on our previuos device, which has x86=0Apla=
tform.=0A=0AI am currently out of ideas what to do next.. It seems to me li=
ke a cache=0Acoherency problem. Can anyone suggest what might be wrong?=0A=
=0A--=0A_______________________________________________=0ALinuxppc-embedded=
 mailing list=0ALinuxppc-embedded@ozlabs.org=0Ahttps://ozlabs.org/mailman/l=
istinfo/linuxppc-embedded=0A=0A
--0-1973371712-1160674351=:56748
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">Yeah it looks like a cache coherency problem from=
 the first look.</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times =
new roman, new york, times, serif">You may try enabling snooping on the DMA=
 channel if MPC824X supports it. Check in Mode register setting.</DIV>=0A<D=
IV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times,=
 serif">Else you may want to use <FONT face=3DArial color=3Dnavy size=3D2><=
SPAN style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">flush_dcach=
e_range(start, last) <FONT color=3D#000000>functions and see if it helps.</=
FONT></SPAN></FONT>=0A<P class=3DMsoNormal><FONT face=3DArial color=3Dnavy =
size=3D2><SPAN style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial"><=
?xml:namespace prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office=
" /><o:p>&nbsp;</o:p></SPAN></FONT></P></DIV>=0A<DIV style=3D"FONT-SIZE: 12=
pt; FONT-FAMILY: times new roman, new york, times, serif">----- Original Me=
ssage ----<BR>From: Lauri Ehrenpreis &lt;lauri.ehrenpreis@liewenthal.ee&gt;=
<BR>To: linuxppc-embedded@ozlabs.org<BR>Sent: Wednesday, October 11, 2006 7=
:20:03 AM<BR>Subject: Problems with DMA from user space on MPC834x (Cache c=
oherency?)<BR><BR>=0A<DIV>Hi!<BR><BR>I have a problem with DMA from user sp=
ace on a platform powered by MPC834x<BR>processor (which has powerpc e300 c=
ore inside). Our linux kernel version is<BR>2.6.17.<BR><BR>My user space pr=
ogram does something like this:<BR><BR>file_fd =3D open("/disk/file", O_RDO=
NLY);<BR>result =3D read(file_fd, page_aligned_buf, len);<BR>call_driver_io=
ctl_which_performs_dma();<BR><BR>while /disk is mounted to a partition resi=
ding on USB memory stick or SD<BR>card.<BR>page_aligned_buf starts from pag=
e boundary and contains enough full pages<BR>for<BR>the data (so I can allw=
ays map full page with dma_map_page in kernel).<BR><BR>The buffer address a=
nd data length will then be passed to a driver, which<BR>calls<BR>get_user_=
pages, then maps each page with dma_map_page and tells a PCI<BR>device<BR>t=
o start reading from that page:<BR><BR>...<BR>down_read(&amp;current-&gt;mm=
-&gt;mmap_sem);<BR>result =3D get_user_pages(current, current-&gt;mm, page_=
aligned_buf, nr_pages,<BR>0, 0, pages,
 NULL);<BR>up_read(&amp;current-&gt;mm-&gt;mmap_sem);<BR><BR>for (i =3D 0; =
i &lt; nr_pages; i++) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;find_data_checksum(pages=
[i]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;dma_addr =3D dma_map_page(&amp;fpga.pci_de=
v-&gt;dev, pages[i], 0, PAGE_SIZE,<BR>DMA_TO_DEVICE);<BR><BR>&nbsp;&nbsp;&n=
bsp;&nbsp;start_dma();<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;wait_until_dma_ready(=
);<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;dma_unmap_page(&amp;fpga.pci_dev-&gt;dev,=
 dma_addr, dma_len, DMA_TO_DEVICE);<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;if(!chec=
ksum_ok_in_fpga())<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print=
_page_data();<BR>}<BR><BR>for (i =3D 0; i &lt; nr_pages; i++)<BR>&nbsp;&nbs=
p;&nbsp;&nbsp;page_cache_release(pages[i]);<BR><BR>The problem is that some=
times the PCI device receives wrong bytes at random<BR>locations. I find th=
e data checksum inside the driver and inside the FPGA.<BR>Inside the driver=
 I use kmap(page) and kunmap(page) to access data on the<BR>user page. Some=
times the checksums
 do not match and I can see with the FPGA<BR>debugging tool, that the FPGA =
receives different data than the driver is<BR>printing out.<BR><BR>I have n=
oticed 3 things regarding this error:<BR>1) When I copy the data I read fro=
m the block device to another buffer in<BR>userspace and pass this new buff=
er to the driver, then this error will<BR>never occur:<BR><BR>file_fd =3D o=
pen("/disk/file", O_RDONLY);<BR>result =3D read(file_fd, page_aligned_buf, =
len);<BR>memcpy(new_page_aligned_buf, page_aligned_buf, len);<BR>call_drive=
r_ioctl_which_performs_dma(new_page_aligned_buf, len);<BR><BR>2) this error=
 does not occur when I use copy_from_user instead of<BR>get_user_pages<BR>a=
nd dma_map_page inside driver.<BR><BR>3) this error does not occur on our p=
reviuos device, which has x86<BR>platform.<BR><BR>I am currently out of ide=
as what to do next.. It seems to me like a cache<BR>coherency problem. Can =
anyone suggest what might be
 wrong?<BR><BR>--<BR>_______________________________________________<BR>Lin=
uxppc-embedded mailing list<BR>Linuxppc-embedded@ozlabs.org<BR><A href=3D"h=
ttps://ozlabs.org/mailman/listinfo/linuxppc-embedded" target=3D_blank>https=
://ozlabs.org/mailman/listinfo/linuxppc-embedded</A></DIV></DIV>=0A<DIV sty=
le=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif=
"><BR></DIV></div><br></body></html>
--0-1973371712-1160674351=:56748--
