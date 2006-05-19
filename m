Return-Path: <codevana@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id BF717679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 07:28:31 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 36so711189wra
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 14:28:29 -0700 (PDT)
Message-ID: <7cb1293c0605191428n57c18a60h5b86863d729cd9b9@mail.gmail.com>
Date: Fri, 19 May 2006 14:28:29 -0700
From: "Srinivas Murthy" <codevana@gmail.com>
To: "Linas Vepstas" <linas@austin.ibm.com>
Subject: Re: PPC host with a PCI root-complex
In-Reply-To: <20060519162310.GI12135@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_138553_15036780.1148074109138"
References: <7cb1293c0605181456p3c1726e2n56942dfbd4217f70@mail.gmail.com>
	<20060519162310.GI12135@austin.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_138553_15036780.1148074109138
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for the reply.

I have a couple of concerns here. I would appreciate if you could provide
your thoughts.

On a PPC (44x) platform, following an error such as parity error detected b=
y
the PCI root complex, should we cause a bus error (causing a machine-check
exception) or complete the bus transaction normally but trigger a critical
interrupt? Note that these are two diff types of interrupts as seen by the
CPU with the machine check having the highest NMI priority.

If the parity error detection was a result of say a memory read operation b=
y
the core to a PCI device, there might be a several cycle diff between the
read and the cpu being interrupted (with the critical interrupt handler).
This may result in data corruption, etc. Is this a valid concern to have?
What is the normal approach to deal with this issue in an "enterprise" or
high-end environment?










On 5/19/06, Linas Vepstas <linas@austin.ibm.com> wrote:
>
> On Thu, May 18, 2006 at 02:56:31PM -0700, Srinivas Murthy wrote:
> > Hi,
> >
> > We have a ppc host with a PCI root-complex across which there are
> multiple
> > PCI end points.
> >
> > An application running on the ppc host reading one of the device memory
> > regions (not DMA access but direct CPU read) causes a parity error on
> the
> > PCI interface controller.
> >
> > We think that the error should be propagated up as a machine-check whic=
h
> is
> > considered a non-recoverable system-wide error. However with multiple
> PCI
> > devices present we think that this is too generic and could be reduced
> to be
> > a critical-error which could be recovered from.
>
> The "PCI Error Recovery" API was created to deal with this kind of a
> situation. See Documentation/pci-error-recovery.txt
>
> In breif: if something like a PCI parity error is detected by the
> hardware, then some arch-specific code runs; for example,
> arch/powerpc/platforms/pseries/eeh.c.
>
> This code notifies the PCI device driver (via generic callbacks in
> include/linux/pci.h) about the error. The device driver may ask the
> arch to have the pci device/bus/link/etc/ get reset, or not.  If/when
> the PCI bus/link is back to normal, the PCI device driver is notified
> via callback, and resumes normal operation.
>
> If you have questions/suggestions, let me know, I've been maintaining
> this code, and am interested in seeing how well it can be adapted
> to a broader range of hardware.
>
> --linas
>

------=_Part_138553_15036780.1148074109138
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Thanks for the reply.</div>
<div>&nbsp;</div>
<div>I have a couple of concerns here. I would appreciate if you could prov=
ide your thoughts.</div>
<div>&nbsp;</div>
<div>On a PPC (44x)&nbsp;platform, following an error such as parity error =
detected by the PCI root complex, should we cause a bus error (causing a ma=
chine-check exception) or complete the bus transaction normally but trigger=
 a critical interrupt? Note that&nbsp;these are two diff types of interrupt=
s as seen by the CPU with the machine check having the highest NMI priority=
.
</div>
<div>&nbsp;</div>
<div>If the parity error detection was a result of say&nbsp;a memory read o=
peration by the core to a PCI device, there might be a several cycle diff b=
etween the read and the cpu being interrupted (with the critical interrupt =
handler). This may result in data corruption, etc. Is this a valid concern =
to have? What is the normal approach to deal with this issue in an &quot;en=
terprise&quot; or high-end environment?
</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/19/06, <b class=3D"gmail_sendername">=
Linas Vepstas</b> &lt;<a href=3D"mailto:linas@austin.ibm.com">linas@austin.=
ibm.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thu, May 18, 2006 at 02:56:31=
PM -0700, Srinivas Murthy wrote:<br>&gt; Hi,<br>&gt;<br>&gt; We have a ppc =
host with a PCI root-complex across which there are multiple
<br>&gt; PCI end points.<br>&gt;<br>&gt; An application running on the ppc =
host reading one of the device memory<br>&gt; regions (not DMA access but d=
irect CPU read) causes a parity error on the<br>&gt; PCI interface controll=
er.
<br>&gt;<br>&gt; We think that the error should be propagated up as a machi=
ne-check which is<br>&gt; considered a non-recoverable system-wide error. H=
owever with multiple PCI<br>&gt; devices present we think that this is too =
generic and could be reduced to be
<br>&gt; a critical-error which could be recovered from.<br><br>The &quot;P=
CI Error Recovery&quot; API was created to deal with this kind of a<br>situ=
ation. See Documentation/pci-error-recovery.txt<br><br>In breif: if somethi=
ng like a PCI parity error is detected by the
<br>hardware, then some arch-specific code runs; for example,<br>arch/power=
pc/platforms/pseries/eeh.c.<br><br>This code notifies the PCI device driver=
 (via generic callbacks in<br>include/linux/pci.h) about the error. The dev=
ice driver may ask the
<br>arch to have the pci device/bus/link/etc/ get reset, or not.&nbsp;&nbsp=
;If/when<br>the PCI bus/link is back to normal, the PCI device driver is no=
tified<br>via callback, and resumes normal operation.<br><br>If you have qu=
estions/suggestions, let me know, I've been maintaining
<br>this code, and am interested in seeing how well it can be adapted<br>to=
 a broader range of hardware.<br><br>--linas<br></blockquote></div><br>

------=_Part_138553_15036780.1148074109138--
