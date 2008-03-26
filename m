Return-Path: <liuxs226@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 31277DE036
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 21:13:16 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so835038anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 03:13:15 -0700 (PDT)
Message-ID: <e81b2fb40803260313i14fe5a6dmc21513180466c454@mail.gmail.com>
Date: Wed, 26 Mar 2008 18:13:14 +0800
From: "=?GB2312?B?wfXQocur?=" <liuxs226@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: system call ioctl() problem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11580_2595299.1206526395037"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11580_2595299.1206526395037
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,all
  Here is a question I didn't make out, i wonder if anybody can figure it
out. My platform is mpc8540 with graphics chip Fujitsu MB86296, my kernel
version is 2.6.12.6. I'm about to write a gfxdriver so DirectFB can call
this gfxdriver to make MB86296 do some drawing things. I wrote a program to
test if the MB86296 drawing registers can be read and written. here is some
part of the pragram:
/* fbtest.c */
int fb; //descriptor of framebuffer device
unsigned long mmio;
fb = open("/dev/fb",O_RDWR);
mmio = (unsigned long
*)mmap(0,0x2000000,PROT_READ|PROT_WRITE,MAP_SHARED,fb,0);

unsigned long ntest=0x5f5f5f5f;
*( unsigned long
*)(mmio+GDC_DRAW_BASE-GDC_HOST_BASE+GDC_REG_BACKGROUND_COLOR)=ntest; // set
value in Background Color register with ntest
printf("*( unsigned long
*)(mmio+GDC_DRAW_BASE-GDC_HOST_BASE+GDC_REG_BACKGROUND_COLOR)=%x\n",*(unsigned
long *)(mmio+GDC_DRAW_BASE-GDC_HOST_BASE+GDC_REG_BACKGROUND_COLOR));
msync((void *)mmio,0x2000000,MS_SYNC);

unsigned long ioctlReadRes[2];
ioctlReadRes[0]=GDC_REG_BACKGROUND_COLOR;  //Background Color register
offset address from drawing register bsae address
printf("ioctlReadRes = %x\n",ioctlReadRes);
ioctl(fb,FBIO_MB86290_READ_DRAW_REG,ioctlReadRes); // read what is in
Background Color register,put it in ioctlReadRes[1]
printf("ioctlReadRes[0]=%x,ioctlReadRes[1]=%x\n",ioctlReadRes[0],ioctlReadRes[1]);

Then I use debug tool strace to trace exe of this program,here is the
result:

bash-3.00# strace ./fbtest
execve("./fbtest", ["./fbtest"], [/* 18 vars */]) = 0
uname({sys="Linux", node="super85xx", ...}) = 0
brk(0)                                  = 0x10011000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30017000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/mnt/gtkdfb/lib/tls/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/mnt/gtkdfb/lib/tls", 0x7fe46fb8) = -1 ENOENT (No such file or
directory)
open("/mnt/gtkdfb/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/mnt/gtkdfb/lib", {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=12946, ...}) = 0
mmap(NULL, 12946, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30018000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\307"..., 512)
=
512
fstat64(3, {st_mode=S_IFREG|0777, st_size=1303116, ...}) = 0
mmap(0xfeab000, 1328676, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0)
= 0xfeab000
mprotect(0xffd8000, 95780, PROT_NONE)   = 0
mmap(0xffe7000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12c000) = 0xffe7000
mmap(0xffed000, 9764, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffed000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x3001c000
mprotect(0xffe7000, 8192, PROT_READ)    = 0
mprotect(0x30026000, 4096, PROT_READ)   = 0
munmap(0x30018000, 12946)               = 0
open("/dev/fb", O_RDWR)                 = 3
mmap(NULL, 33554432, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x30028000
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(5, 1), ...}) = 0
ioctl(1, TCGETS or TCGETS, {B115200 opost isig icanon echo ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x32028000
write(1, "*( unsigned long *)(mmio+GDC_DRA"..., 74*( unsigned long
*)(mmio+GDC_DRAW_BASE+GDC_REG_BACKGROUND_COLOR)=5f5f5f5f
) = 74
msync(0x30028000, 33554432, MS_SYNC)    = 0
write(1, "ioctlReadRes = 7fe47914\n", 24ioctlReadRes = 7fe47914
) = 24
ioctl(3, 0x20004d2f, 0x7fe47914)        = -1 EINVAL (Invalid argument)
write(1, "ioctlReadRes[0]=484,ioctlReadRes"...,
45ioctlReadRes[0]=484,ioctlReadRes[1]=30026f58
) = 45
munmap(0x32028000, 4096)                = 0
exit_group(45)                          = ?


from above, I think the problem is in ioctl call, which shows "EINVAL
(Invalid argument)", so I added printk() to xx_ioctl() in fb driver, and it
showed xx_ioctl() was not called .Then I checked xx_ioctl() was right.
where is my problem? how to call ioctl() right??
Thanks

------=_Part_11580_2595299.1206526395037
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p>hi,all<br>&nbsp; Here is a question I didn&#39;t make out, i wonder if anybody can figure it out. My platform is mpc8540 with graphics chip Fujitsu MB86296, my kernel version is <a href="http://2.6.12.6">2.6.12.6</a>. I&#39;m about to write a gfxdriver so DirectFB can call this gfxdriver to make MB86296 do some drawing things. I wrote a program to test if the MB86296 drawing registers can be read and written. here is some part of the pragram:<br>
/* fbtest.c */<br>int fb; //descriptor of framebuffer device<br>unsigned long mmio; <br>fb = open(&quot;/dev/fb&quot;,O_RDWR);&nbsp; <br>mmio = (unsigned long *)mmap(0,0x2000000,PROT_READ|PROT_WRITE,MAP_SHARED,fb,0);</p>
<p>unsigned long ntest=0x5f5f5f5f;<br>*( unsigned long *)(mmio+GDC_DRAW_BASE-GDC_HOST_BASE+GDC_REG_BACKGROUND_COLOR)=ntest; // set value in Background Color register with ntest<br>printf(&quot;*( unsigned long *)(mmio+GDC_DRAW_BASE-GDC_HOST_BASE+GDC_REG_BACKGROUND_COLOR)=%x\n&quot;,*(unsigned long *)(mmio+GDC_DRAW_BASE-GDC_HOST_BASE+GDC_REG_BACKGROUND_COLOR));<br>
msync((void *)mmio,0x2000000,MS_SYNC); </p>
<p>unsigned long ioctlReadRes[2];<br>ioctlReadRes[0]=GDC_REG_BACKGROUND_COLOR;&nbsp; //Background Color register offset address from drawing register bsae address<br>printf(&quot;ioctlReadRes = %x\n&quot;,ioctlReadRes);<br>ioctl(fb,FBIO_MB86290_READ_DRAW_REG,ioctlReadRes); // read what is in Background Color register,put it in ioctlReadRes[1]<br>
printf(&quot;ioctlReadRes[0]=%x,ioctlReadRes[1]=%x\n&quot;,ioctlReadRes[0],ioctlReadRes[1]);</p>
<p>Then I use debug tool strace to trace exe of this program,here is the result:</p>
<p>bash-3.00# strace ./fbtest<br>execve(&quot;./fbtest&quot;, [&quot;./fbtest&quot;], [/* 18 vars */]) = 0<br>uname({sys=&quot;Linux&quot;, node=&quot;super85xx&quot;, ...}) = 0<br>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x10011000<br>
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =<br>0x30017000<br>access(&quot;/etc/ld.so.preload&quot;, R_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or<br>directory)<br>open(&quot;/mnt/gtkdfb/lib/tls/libc.so.6&quot;, O_RDONLY) = -1 ENOENT (No such file or<br>
directory)<br>stat64(&quot;/mnt/gtkdfb/lib/tls&quot;, 0x7fe46fb8) = -1 ENOENT (No such file or<br>directory)<br>open(&quot;/mnt/gtkdfb/lib/libc.so.6&quot;, O_RDONLY) = -1 ENOENT (No such file or<br>directory)<br>stat64(&quot;/mnt/gtkdfb/lib&quot;, {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0<br>
open(&quot;/etc/ld.so.cache&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 3<br>fstat64(3, {st_mode=S_IFREG|0644, st_size=12946, ...}) = 0<br>mmap(NULL, 12946, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30018000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
open(&quot;/lib/tls/libc.so.6&quot;, O_RDONLY)&nbsp;&nbsp;&nbsp; = 3<br>read(3, &quot;\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\307&quot;..., 512) =<br>512<br>fstat64(3, {st_mode=S_IFREG|0777, st_size=1303116, ...}) = 0<br>mmap(0xfeab000, 1328676, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)<br>
= 0xfeab000<br>mprotect(0xffd8000, 95780, PROT_NONE)&nbsp;&nbsp; = 0<br>mmap(0xffe7000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC,<br>MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12c000) = 0xffe7000<br>mmap(0xffed000, 9764, PROT_READ|PROT_WRITE|PROT_EXEC,<br>
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffed000<br>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =<br>0x3001c000<br>mprotect(0xffe7000, 8192, PROT_READ)&nbsp;&nbsp;&nbsp; = 0<br>
mprotect(0x30026000, 4096, PROT_READ)&nbsp;&nbsp; = 0<br>munmap(0x30018000, 12946)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>open(&quot;/dev/fb&quot;, O_RDWR)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 3<br>mmap(NULL, 33554432, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x30028000<br>
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(5, 1), ...}) = 0<br>ioctl(1, TCGETS or TCGETS, {B115200 opost isig icanon echo ...}) = 0<br>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =<br>0x32028000<br>
write(1, &quot;*( unsigned long *)(mmio+GDC_DRA&quot;..., 74*( unsigned long<br>*)(mmio+GDC_DRAW_BASE+GDC_REG_BACKGROUND_COLOR)=5f5f5f5f<br>) = 74<br>msync(0x30028000, 33554432, MS_SYNC)&nbsp;&nbsp;&nbsp; = 0<br>write(1, &quot;ioctlReadRes = 7fe47914\n&quot;, 24ioctlReadRes = 7fe47914<br>
) = 24<br>ioctl(3, 0x20004d2f, 0x7fe47914)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 EINVAL (Invalid argument)<br>write(1, &quot;ioctlReadRes[0]=484,ioctlReadRes&quot;...,<br>45ioctlReadRes[0]=484,ioctlReadRes[1]=30026f58<br>) = 45<br>munmap(0x32028000, 4096)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
exit_group(45)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = ?</p>
<p><br>from above, I think the problem is in ioctl call, which shows &quot;EINVAL (Invalid argument)&quot;, so I added printk() to xx_ioctl() in fb driver, and it showed xx_ioctl() was not called .Then I checked xx_ioctl() was right.&nbsp; where is my problem? how to call ioctl() right??<br>
Thanks</p>

------=_Part_11580_2595299.1206526395037--
