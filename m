Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
Date: Tue, 13 May 2003 16:33:50 -0700
To: Paul Mackerras <paulus@samba.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: set_rtc_time() cleanup / normalization
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16065.31312.163813.582334@argo.ozlabs.ibm.com>
References: <20030512211733.B489EC6092@atlas.denx.de>
 <20030512211733.B489EC6092@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 04:05 PM 5/13/2003, Paul Mackerras wrote:

>Wolfgang Denk writes:
>
> > I would like to find out if there is some consensus about the use  of
> > set_rtc_time() in the timer interrupt handler.
>
>The consensus so far seems to be that we shouldn't call set_rtc_time
>in the timer interrupt handler.  Is anyone willing to speak up with a
>reason why we should keep it?

Because there are systems which rely on this behavior?
For example, all our embedded systems use this feature.

Wolfgang said that "... many embedded systems run in a configuration
where they use a high precision RTC chip...".

All embedded systems I saw used cheap RTC parts with poor accuracy.

I think we mix two different issues here:

1) call set_rtc_time() from timer interrupt every 11 min if clock is
synched (e.g. by NTP)
    I don't see any problems with this.

2) set_rtc_time() implementation for concrete RTC device *maybe* slow or
just cannot
    be called from the interrupt context.
    Why just don't fix actual RTC code in each case ?
    It may be useful to provide some *generic* facility for such cases.

Eugene.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
