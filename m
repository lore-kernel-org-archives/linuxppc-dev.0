Return-Path: <whchung@us.ibm.com>
In-Reply-To: <200609131935.17746.arnd.bergmann@de.ibm.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [Cbe-oss-dev] automount support
From: William Chung <whchung@us.ibm.com>
Message-ID: <OFA201BCF4.3B7FA605-ON852571E8.0063942F-852571E8.00668E8E@us.ibm.com>
Date: Wed, 13 Sep 2006 14:40:10 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 00668E01852571E8_="
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev-bounces+whchung=us.ibm.com@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00668E01852571E8_=
Content-Type: text/plain; charset="US-ASCII"

Arnd,

I appreciate your quick response.

On Wednesday 13 September 2006 13:35 EDT, Arnd Bergmann wrote:
> While there are no technical reasons against it, it increases build
> time on my development system, and I generally try to avoid
> adding modules that are not generally needed.

Fortunately, the autofs modules aren't large so they don't add 
significantly to the build time.  The motivation for including some form 
of automounter support in the cell kernel is because cell blades are 
usually used in groups of more than one.  So, it's often desirable to have 
a common filesystem between them.

> I guess having one of them is pretty common, but not both.
> Which one do you prefer?

autofs4 is supposedly backwardly compatible with autofs (v3), so I'd 
prefer autofs4.  I hear that having only autofs4 as a module can require 
adding the line "alias autofs autofs4" to /etc/modprobe.conf to let 
modutils look for autofs4 when the kernel needs autofs.  I'm not sure that 
this line is necessary though because I built a kernel with both autofs 
and autofs4 enabled as modules and it looks like only autofs4 gets loaded, 
without any changes to my /etc/modprobe.conf file.  Hopefully, someone 
more experienced with autofs can give some guidance here.

I refer to autofs4 as a module above because I'm going to tentatively say 
that it'd be better to build autofs4 as a module, rather than into the 
kernel (CONFIG_AUTOFS4_FS=m).  Once again, those more experienced with 
kernel configuration and autofs should confirm how autofs4 should be 
enabled.

Regards,
- Bill.

*****************
William Chung
IBM T.J. Watson Research Center
Hawthorne, New York, USA
Tel: 1-914-784-7552    whchung@us.ibm.com




Arnd Bergmann <arnd.bergmann@de.ibm.com> 
Sent by: cbe-oss-dev-bounces+whchung=us.ibm.com@ozlabs.org
09/13/2006 01:35 PM

To
cbe-oss-dev@ozlabs.org
cc
linuxppc-dev@ozlabs.org
Subject
Re: [Cbe-oss-dev] automount support






On Wednesday 13 September 2006 17:01, William Chung wrote:
> I noticed that the stock cell kernel does not enable the autofs and 
> autofs4 modules.  The stock Fedora Core 5 kernel does have these modules 

> enabled.  What is the reason for disabling automount support?  Would 
there 
> be any issues to changing arch/powerpc/configs/cell_defconfig to enable 
> the autofs and autofs4 modules?

While there are no technical reasons against it, it increases build
time on my development system, and I generally try to avoid
adding modules that are not generally needed.

The other defconfig files are inconsistent in this regard:

arch/powerpc/configs/cell_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/cell_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/chrp32_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/chrp32_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/g5_defconfig:CONFIG_AUTOFS_FS=m
arch/powerpc/configs/g5_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/iseries_defconfig:CONFIG_AUTOFS_FS=m
arch/powerpc/configs/iseries_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/maple_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/maple_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/pmac32_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/pmac32_defconfig:CONFIG_AUTOFS4_FS=m
arch/powerpc/configs/ppc64_defconfig:CONFIG_AUTOFS_FS=y
arch/powerpc/configs/ppc64_defconfig:# CONFIG_AUTOFS4_FS is not set
arch/powerpc/configs/pseries_defconfig:# CONFIG_AUTOFS_FS is not set
arch/powerpc/configs/pseries_defconfig:CONFIG_AUTOFS4_FS=m

I guess having one of them is pretty common, but not both.
Which one do you prefer?

                 Arnd <><
_______________________________________________
cbe-oss-dev mailing list
cbe-oss-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/cbe-oss-dev


--=_alternative 00668E01852571E8_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Arnd,</font>
<br>
<br><font size=2 face="sans-serif">I appreciate your quick response.</font>
<br>
<br><tt><font size=2>On Wednesday 13 September 2006 13:35 EDT, Arnd Bergmann
wrote:<br>
&gt; While there are no technical reasons against it, it increases build<br>
&gt; time on my development system, and I generally try to avoid<br>
&gt; adding modules that are not generally needed.</font></tt>
<br>
<br><font size=2 face="sans-serif">Fortunately, the autofs modules aren't
large so they don't add significantly to the build time. &nbsp;The motivation
for including some form of automounter support in the cell kernel is because
cell blades are usually used in groups of more than one. &nbsp;So, it's
often desirable to have a common filesystem between them.</font>
<br>
<br><tt><font size=2>&gt; I guess having one of them is pretty common,
but not both.<br>
&gt; Which one do you prefer?</font></tt>
<br>
<br><font size=2 face="sans-serif">autofs4 is supposedly backwardly compatible
with autofs (v3), so I'd prefer autofs4. &nbsp;I hear that having only
autofs4 as a module can require adding the line &quot;alias autofs autofs4&quot;
to /etc/modprobe.conf to let modutils look for autofs4 when the kernel
needs autofs. &nbsp;I'm not sure that this line is necessary though because
I built a kernel with both autofs and autofs4 enabled as modules and it
looks like only autofs4 gets loaded, without any changes to my /etc/modprobe.conf
file. &nbsp;Hopefully, someone more experienced with autofs can give some
guidance here.</font>
<br>
<br><font size=2 face="sans-serif">I refer to autofs4 as a module above
because I'm going to tentatively say that it'd be better to build autofs4
as a module, rather than into the kernel (CONFIG_AUTOFS4_FS=m). &nbsp;Once
again, those more experienced with kernel configuration and autofs should
confirm how autofs4 should be enabled.</font>
<br><font size=2 face="sans-serif"><br>
Regards,<br>
- Bill.<br>
<br>
*****************<br>
William Chung<br>
IBM T.J. Watson Research Center<br>
Hawthorne, New York, USA<br>
Tel: 1-914-784-7552 &nbsp; &nbsp;whchung@us.ibm.com</font>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Arnd Bergmann &lt;arnd.bergmann@de.ibm.com&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: cbe-oss-dev-bounces+whchung=us.ibm.com@ozlabs.org</font>
<p><font size=1 face="sans-serif">09/13/2006 01:35 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">cbe-oss-dev@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">linuxppc-dev@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [Cbe-oss-dev] automount support</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>On Wednesday 13 September 2006 17:01, William Chung
wrote:<br>
&gt; I noticed that the stock cell kernel does not enable the autofs and
<br>
&gt; autofs4 modules. &nbsp;The stock Fedora Core 5 kernel does have these
modules <br>
&gt; enabled. &nbsp;What is the reason for disabling automount support?
&nbsp;Would there <br>
&gt; be any issues to changing arch/powerpc/configs/cell_defconfig to enable
<br>
&gt; the autofs and autofs4 modules?<br>
<br>
While there are no technical reasons against it, it increases build<br>
time on my development system, and I generally try to avoid<br>
adding modules that are not generally needed.<br>
<br>
The other defconfig files are inconsistent in this regard:<br>
<br>
arch/powerpc/configs/cell_defconfig:# CONFIG_AUTOFS_FS is not set<br>
arch/powerpc/configs/cell_defconfig:# CONFIG_AUTOFS4_FS is not set<br>
arch/powerpc/configs/chrp32_defconfig:# CONFIG_AUTOFS_FS is not set<br>
arch/powerpc/configs/chrp32_defconfig:# CONFIG_AUTOFS4_FS is not set<br>
arch/powerpc/configs/g5_defconfig:CONFIG_AUTOFS_FS=m<br>
arch/powerpc/configs/g5_defconfig:# CONFIG_AUTOFS4_FS is not set<br>
arch/powerpc/configs/iseries_defconfig:CONFIG_AUTOFS_FS=m<br>
arch/powerpc/configs/iseries_defconfig:# CONFIG_AUTOFS4_FS is not set<br>
arch/powerpc/configs/maple_defconfig:# CONFIG_AUTOFS_FS is not set<br>
arch/powerpc/configs/maple_defconfig:# CONFIG_AUTOFS4_FS is not set<br>
arch/powerpc/configs/pmac32_defconfig:# CONFIG_AUTOFS_FS is not set<br>
arch/powerpc/configs/pmac32_defconfig:CONFIG_AUTOFS4_FS=m<br>
arch/powerpc/configs/ppc64_defconfig:CONFIG_AUTOFS_FS=y<br>
arch/powerpc/configs/ppc64_defconfig:# CONFIG_AUTOFS4_FS is not set<br>
arch/powerpc/configs/pseries_defconfig:# CONFIG_AUTOFS_FS is not set<br>
arch/powerpc/configs/pseries_defconfig:CONFIG_AUTOFS4_FS=m<br>
<br>
I guess having one of them is pretty common, but not both.<br>
Which one do you prefer?<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Arnd &lt;&gt;&lt;<br>
_______________________________________________<br>
cbe-oss-dev mailing list<br>
cbe-oss-dev@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/cbe-oss-dev<br>
</font></tt>
<br>
--=_alternative 00668E01852571E8_=--
