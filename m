Return-Path: <Thomas.Waldecker@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [82.210.228.1])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "IronPort Appliance Demo Certificate",
 Issuer "IronPort Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B25F2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 20:41:32 +1100 (EST)
From: Thomas Waldecker <Thomas.Waldecker@tqs.de>
To: Scott Wood <scottwood@freescale.com>
Subject: AW: Why is the e500v2 core not using cpuidle?
Date: Sat, 2 Feb 2013 09:41:27 +0000
Message-ID: <B88C075EE1324644BA0452D5EFDD5828139523EA@TQ-MAIL.tq-net.de>
References: <B88C075EE1324644BA0452D5EFDD58281395211D@TQ-MAIL.tq-net.de>
 (from Thomas.Waldecker@tqs.de on Fri Feb  1 06:06:05
 2013),<1359742517.23561.2@snotra>
In-Reply-To: <1359742517.23561.2@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Cc: "Linux PPC dev mailing list \(linuxppc-dev@lists.ozlabs.org\)"
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,=0A=
=0A=
>> Why is there no support for the cpuidle framework?=0A=
> Because nobody implemented it. :-)=0A=
That's the reason I thought before :-)=0A=
=0A=
> The only reason I can think of to implement it on this chip would be to=
=0A=
> dynamically choose when to enter nap versus doze, rather than always=0A=
> just using doze.  It's not clear whether the difference in power=0A=
> savings is worth it -- do you have any way of measuring?=0A=
=0A=
Is the e500 only using doze? There are comments in the file =0A=
arch/powerpc/kernel/idle_e500.S=0A=
which are stating:=0A=
/*  Go to NAP or DOZE now */=0A=
or=0A=
/* Return from NAP/DOZE ...*/=0A=
=0A=
and because of this comments I thought that both modes are in use.=0A=
=0A=
I have a way of measuring the power and it is also a small part of my maste=
rthesis,=0A=
but it is not very meaningful because at the measuring point there are othe=
r peripheral=0A=
components too.=0A=
=0A=
According to the comments can I activate the nap mode somehow?=0A=
=0A=
>> How can I debug the e500 idle modes?=0A=
>> Are there any statistics?=0A=
> Top reports idle percentage...=0A=
If the e500 and e500v2 are indeed using only the doze mode it =0A=
would be enough statistics.=0A=
=0A=
>> I already ran PowerTOP on a QorIQ P2020 but it's almost useless=0A=
>> because the information is missing.=0A=
> What information are you looking for?=0A=
=0A=
On my laptop I get detailled idle stats in PowerTOP 2.2=0A=
=0A=
          Package   |            CPU 0=0A=
POLL        0.0%    | POLL        0.0%    0.0 ms=0A=
C1          0.7%    | C1          0.4%    0.2 ms=0A=
C2         86.0%    | C2         86.8%    1.4 ms=0A=
=0A=
                    |            CPU 1=0A=
                    | POLL        0.0%    0.4 ms=0A=
                    | C1          0.9%    0.6 ms=0A=
                    | C2         85.2%    1.5 ms=0A=
=0A=
It is using the sysfs interface=0A=
=0A=
thomas@localhost /s/d/s/c/c/cpuidle> pwd=0A=
/sys/devices/system/cpu/cpu0/cpuidle=0A=
thomas@localhost /s/d/s/c/c/cpuidle> tree=0A=
.=0A=
=86=80=80 state0=0A=
=81=9A=9A =86=80=80 desc=0A=
=81=9A=9A =86=80=80 disable=0A=
=81=9A=9A =86=80=80 latency=0A=
=81=9A=9A =86=80=80 name=0A=
=81=9A=9A =86=80=80 power=0A=
=81=9A=9A =86=80=80 time=0A=
=81=9A=9A =84=80=80 usage=0A=
=86=80=80 state1=0A=
    (same as state0)=0A=
=84=80=80 state2=0A=
    (also same as state 0)=0A=
thomas@localhost /s/d/s/c/c/cpuidle> cat */name=0A=
POLL=0A=
C1=0A=
C2=0A=
=0A=
Such statistics would be great for the doze, nap (and sleep for the whole p=
ackage).=0A=
=0A=
Kind regards,=0A=
Thomas=
