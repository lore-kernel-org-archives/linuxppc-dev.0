Return-Path: <dceravigupta@gmail.com>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) by ozlabs.org (Postfix) with ESMTP id 528E2B70B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 03:36:11 +1000 (EST)
Received: by pxi2 with SMTP id 2so188449pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Jul 2010 10:36:09 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 26 Jul 2010 22:58:30 +0530
Message-ID: <AANLkTikJJYRP=5yPQ8dG9ofXz3HvWzfQU2kt4PDui7EF@mail.gmail.com>
Subject: Memory Mapping a char array in User Space
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636457d9496fad1048c4db6f2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636457d9496fad1048c4db6f2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am new to linux device driver development and I'm trying to learn the
memory mapping. Currently I have written a simple device driver(major number
251 and minor number 0) and in its mmap(struct file *file, struct
vm_area_struct *vma) function, I am trying to memory map a global character
array (defined in driver) to user space memory.This is my current
implementation

char map[25];

static int test_mmap(struct file *filp, struct vm_area_struct *vma)
{
            strcpy(map, "Hello World!!");
	if (remap_pfn_range(vma, vma->vm_start, page_to_pfn(virt_to_page(map)),
	                    vma->vm_end - vma->vm_start, vma->vm_page_prot)) {
                return -EAGAIN;
	}
	return 0;
}*
*

Now after compiling the driver successfully, I created a character device
file /dev/test0 using mknod command (mknod /dev/test c 251 0). And in my C
program I tried to memory map the /dev/test file.

Now what I want is that whenever I map /dev/test, internally that global
char array gets memory mapped to the user space? Also what should I pass as
the length parameter in the mmap() function? Currently I am passing 25(size
of the array). My device gets memory map successfully but when I tried to
read from it I get garbage value. Is there something that I am missing?

Thanks in advance
Ravi Gupta

--001636457d9496fad1048c4db6f2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am new to linux device driver development and I&#39;m trying t=
o learn the memory mapping. Currently I have written a simple device driver=
(major number 251 and minor number 0) and in its mmap(struct file *file, st=
ruct vm_area_struct *vma) function, I am trying to memory map a global char=
acter array (defined in driver) to user space memory.This is my current imp=
lementation<br>
<br>char map[25];<br><pre class=3D"code c"><font style=3D"font-family: aria=
l,helvetica,sans-serif;" size=3D"2"><span class=3D"kw4">static</span> <span=
 class=3D"kw4">int</span> test_mmap<span class=3D"br0">(</span><span class=
=3D"kw4">struct</span> file <span class=3D"sy0">*</span>filp<span class=3D"=
sy0">,</span> <span class=3D"kw4">struct</span> vm_area_struct <span class=
=3D"sy0">*</span>vma<span class=3D"br0">)</span><br>
<span class=3D"br0">{</span><br>            strcpy(map, &quot;Hello World!!=
&quot;);<br>	<span class=3D"kw1">if</span> <span class=3D"br0">(</span>rema=
p_pfn_range<span class=3D"br0">(</span>vma<span class=3D"sy0">,</span> vma<=
span class=3D"sy0">-&gt;</span>vm_start<span class=3D"sy0">,</span><span st=
yle=3D"font-family: arial,helvetica,sans-serif;"> </span></font><font style=
=3D"font-family: arial,helvetica,sans-serif;" size=3D"2">page_to_pfn(virt_t=
o_page(map))</font><font style=3D"font-family: arial,helvetica,sans-serif;"=
 size=3D"2"><span style=3D"font-family: arial,helvetica,sans-serif;" class=
=3D"sy0">,</span><br>
	                    vma<span class=3D"sy0">-&gt;</span>vm_end <span class=
=3D"sy0">-</span> vma<span class=3D"sy0">-&gt;</span>vm_start<span class=3D=
"sy0">,</span> vma<span class=3D"sy0">-&gt;</span>vm_page_prot<span class=
=3D"br0">)</span><span class=3D"br0">)</span> <span class=3D"br0">{</span><=
br>
                <span class=3D"kw1">return</span> <span class=3D"sy0">-</sp=
an>EAGAIN;<br>	<span class=3D"br0">}</span><br>	<span class=3D"kw1">return<=
/span> <span class=3D"nu19">0</span>;<br><span class=3D"br0">}</span><b><br=
></b></font></pre>
Now after compiling the driver successfully, I created a character device f=
ile /dev/test0 using mknod command (mknod /dev/test c 251 0). And in my C p=
rogram I tried to memory map the /dev/test file.<br><br>Now what I want is =
that whenever I map /dev/test, internally that global char array gets memor=
y mapped to the user space? Also what should I pass as the length parameter=
 in the mmap() function? Currently I am passing 25(size of the array). My d=
evice gets memory map successfully but when I tried to read from it I get g=
arbage value. Is there something that I am missing?<br>
<br>Thanks in advance<br>Ravi Gupta<br>

--001636457d9496fad1048c4db6f2--
