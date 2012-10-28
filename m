Return-Path: <crsrivatstechnical@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DE3C2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Oct 2012 11:46:28 +1100 (EST)
Received: by mail-ee0-f51.google.com with SMTP id d49so1579266eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2012 17:46:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1351297672.23094.13@snotra>
References: <CAO_L5k-D2jMZaoxpxk_tu_=nT5T0PSSp_PUesh9gm-rNq0Qhcg@mail.gmail.com>
 <1351297672.23094.13@snotra>
Date: Sat, 27 Oct 2012 20:46:23 -0400
Message-ID: <CAO_L5k-gKswyECKRbnyxGwT-KrN9yUuLdCkCx2=+T+M_ep_y7w@mail.gmail.com>
Subject: Re: Power Management issues in MPC8313 processor
From: Srivatsan Canchivaram <crsrivatstechnical@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=047d7b622822d2538b04cd13e181
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b622822d2538b04cd13e181
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Scott,

I am using 2.6.27 - I am trying to add Power Management support to an older
product.

Thanks,
Srivatsan

On Fri, Oct 26, 2012 at 8:27 PM, Scott Wood <scottwood@freescale.com> wrote=
:

> On 10/25/2012 05:07:01 PM, Srivatsan Canchivaram wrote:
>
>> Hi,
>>
>>
>> I have a modem with a Freescale MPC8313E processor. I am trying to enabl=
e
>> power savings in the processor by placing it in Standby mode and resume
>> normal operation with a Wake-On-LAN magic packet.
>>
>>
>> Following the directions in the Freescale Power Management app note, I
>> enabled Power Management Support in the Linux kernel and device tree
>> configurations.
>>
>>
>> I ran the following command on the board:
>>
>> echo standby > /sys/power/state
>>
>>
>> This caused the console to hang and there was no further response to
>> keyboard inputs. I enabled =91no_console_suspend=92 in the kernel and wh=
en I
>> loaded the new build and enabled standby mode, I observed an Oops trace:
>>
>>
>>
>> RASCOM_QCU.7.0.0013 $ echo standby > /sys/power/state
>>
>> <6>PM: Syncing fFreezing user space processes ... ilesystems ... <7>PM:
>> Entering standby sleep
>>
>> Unable to handle kernel paging request for instruction fetch
>>
>> Faulting instruction address: 0x616d6570
>>
>> Oops: Kernel access of bad area, sig: 11 [#1]
>>
>> MPC831x RDB
>>
>> Modules linked in: dsp rcspi modem i2c_mpc thermal_sys lm92 hwmon [last
>> unloaded: modem]
>>
>> NIP: 616d6570 LR: c0165224 CTR: 616d6573
>>
>> REGS: cd087d30 TRAP: 0400   Not tainted  (2.6.27)
>>
>> MSR: 20001032 <ME,IR,DR>  CR: 28002024  XER: 20000000
>>
>> TASK =3D cc312400[1196] 'echo' THREAD: cd086000
>>
>> GPR00: 00000002 cd087de0 cc312400 cf821800 cd087de8 00000002 c06e0000
>> c06da4a0
>>
>> GPR08: c06da948 616d6573 00003fff c06c6308 28002022 10091248 0fffc000
>> 100050b8
>>
>> GPR16: 1008a270 10068810 100687c8 10068814 00000000 1008c284 1008c294
>> c0246180
>>
>> GPR24: c02ab9e4 c02ab9dc c06cc4f4 00000006 cd087e08 00000002 c06c595c
>> cf821808
>>
>> NIP [616d6570] 0x616d6570
>>
>> LR [c0165224] platform_pm_suspend_noirq+**0x84/0x88
>>
>
> What kernel are you using?  platform_pm_suspend_noirq was removed by this
> commit:
>
> commit 9b39e73d0c2b265a7f8748b0e9a9f0**9be84079a8
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Sun Dec 18 00:34:24 2011 +0100
>
>     PM / Sleep: Remove forward-only callbacks from platform bus type
>
>     The forward-only PM callbacks provided by the platform bus type are
>     not necessary any more, because the PM core executes driver callbacks
>     when the corresponding subsystem callbacks are not present, so drop
>     them.
>
>     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>
> It seems that a driver's pm ops are getting corrupted -- maybe used after
> freeing?  Have you tried enabling slab/slub debug?
>
> Can you instrument the code to see if there are any fields in the device
> struct that aren't corrupt, that could point out which device this is?
>
>
>  I found another thread that dealt with Power Management issues on the
>> Freescale MPC8313 processor:
>>
>> https://lists.ozlabs.org/**pipermail/linuxppc-dev/2012-**
>> January/095240.html<https://lists.ozlabs.org/pipermail/linuxppc-dev/2012=
-January/095240.html>
>>
>> The resolution of this issue seems to be related to the JTAG TRST pin
>> being
>> disabled. This is not relevant in my case as the TRST on my board is
>> already inactive.
>>
>
> If you were seeing that, you'd see a hang rather than an oops.
>
> -Scott
>

--047d7b622822d2538b04cd13e181
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Scott,<div><br></div><div>I am using 2.6.27 - I am trying to add Powe=
r Management support to an older product.</div><div><br></div><div>Thanks,<=
/div><div>Srivatsan<br><br><div class=3D"gmail_quote">On Fri, Oct 26, 2012 =
at 8:27 PM, Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@fr=
eescale.com" target=3D"_blank">scottwood@freescale.com</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 1=
0/25/2012 05:07:01 PM, Srivatsan Canchivaram wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
<br>
I have a modem with a Freescale MPC8313E processor. I am trying to enable<b=
r>
power savings in the processor by placing it in Standby mode and resume<br>
normal operation with a Wake-On-LAN magic packet.<br>
<br>
<br>
Following the directions in the Freescale Power Management app note, I<br>
enabled Power Management Support in the Linux kernel and device tree<br>
configurations.<br>
<br>
<br>
I ran the following command on the board:<br>
<br>
echo standby &gt; /sys/power/state<br>
<br>
<br>
This caused the console to hang and there was no further response to<br>
keyboard inputs. I enabled =91no_console_suspend=92 in the kernel and when =
I<br>
loaded the new build and enabled standby mode, I observed an Oops trace:<br=
>
<br>
<br>
<br>
RASCOM_QCU.7.0.0013 $ echo standby &gt; /sys/power/state<br>
<br>
&lt;6&gt;PM: Syncing fFreezing user space processes ... ilesystems ... &lt;=
7&gt;PM:<br>
Entering standby sleep<br>
<br>
Unable to handle kernel paging request for instruction fetch<br>
<br>
Faulting instruction address: 0x616d6570<br>
<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>
<br>
MPC831x RDB<br>
<br>
Modules linked in: dsp rcspi modem i2c_mpc thermal_sys lm92 hwmon [last<br>
unloaded: modem]<br>
<br>
NIP: 616d6570 LR: c0165224 CTR: 616d6573<br>
<br>
REGS: cd087d30 TRAP: 0400 =A0 Not tainted =A0(2.6.27)<br>
<br>
MSR: 20001032 &lt;ME,IR,DR&gt; =A0CR: 28002024 =A0XER: 20000000<br>
<br>
TASK =3D cc312400[1196] &#39;echo&#39; THREAD: cd086000<br>
<br>
GPR00: 00000002 cd087de0 cc312400 cf821800 cd087de8 00000002 c06e0000<br>
c06da4a0<br>
<br>
GPR08: c06da948 616d6573 00003fff c06c6308 28002022 10091248 0fffc000<br>
100050b8<br>
<br>
GPR16: 1008a270 10068810 100687c8 10068814 00000000 1008c284 1008c294<br>
c0246180<br>
<br>
GPR24: c02ab9e4 c02ab9dc c06cc4f4 00000006 cd087e08 00000002 c06c595c<br>
cf821808<br>
<br>
NIP [616d6570] 0x616d6570<br>
<br>
LR [c0165224] platform_pm_suspend_noirq+<u></u>0x84/0x88<br>
</blockquote>
<br></div></div>
What kernel are you using? =A0platform_pm_suspend_noirq was removed by this=
 commit:<br>
<br>
commit 9b39e73d0c2b265a7f8748b0e9a9f0<u></u>9be84079a8<br>
Author: Rafael J. Wysocki &lt;<a href=3D"mailto:rjw@sisk.pl" target=3D"_bla=
nk">rjw@sisk.pl</a>&gt;<br>
Date: =A0 Sun Dec 18 00:34:24 2011 +0100<br>
<br>
=A0 =A0 PM / Sleep: Remove forward-only callbacks from platform bus type<br=
>
<br>
=A0 =A0 The forward-only PM callbacks provided by the platform bus type are=
<br>
=A0 =A0 not necessary any more, because the PM core executes driver callbac=
ks<br>
=A0 =A0 when the corresponding subsystem callbacks are not present, so drop=
<br>
=A0 =A0 them.<br>
<br>
=A0 =A0 Signed-off-by: Rafael J. Wysocki &lt;<a href=3D"mailto:rjw@sisk.pl"=
 target=3D"_blank">rjw@sisk.pl</a>&gt;<br>
<br>
It seems that a driver&#39;s pm ops are getting corrupted -- maybe used aft=
er freeing? =A0Have you tried enabling slab/slub debug?<br>
<br>
Can you instrument the code to see if there are any fields in the device st=
ruct that aren&#39;t corrupt, that could point out which device this is?<di=
v class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I found another thread that dealt with Power Management issues on the<br>
Freescale MPC8313 processor:<br>
<br>
<a href=3D"https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-January/095=
240.html" target=3D"_blank">https://lists.ozlabs.org/<u></u>pipermail/linux=
ppc-dev/2012-<u></u>January/095240.html</a><br>
<br>
The resolution of this issue seems to be related to the JTAG TRST pin being=
<br>
disabled. This is not relevant in my case as the TRST on my board is<br>
already inactive.<br>
</blockquote>
<br></div>
If you were seeing that, you&#39;d see a hang rather than an oops.<span cla=
ss=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-Scott<br>
</font></span></blockquote></div><br></div>

--047d7b622822d2538b04cd13e181--
