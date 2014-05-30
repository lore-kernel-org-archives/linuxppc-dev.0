Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by lists.ozlabs.org (Postfix) with ESMTP id 6E3761A06D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 01:54:48 +1000 (EST)
Message-ID: <5388A851.2010508@tabi.org>
Date: Fri, 30 May 2014 10:48:33 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: eshe168 <eshe168@gmail.com>
Subject: Re: P1022 audio driver help!
References: <2014053014034907812079@gmail.com>
In-Reply-To: <2014053014034907812079@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 zhphsearch <zhphsearch@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2014 01:03 AM, eshe168 wrote:
> @timur
> hi,
> Audio card (wm8776) cannot work in full duplex, CPU is FSL P1022.
> The PCB design about audio card reference FSL P1022 development board,
> and palying or recording is OK separately.
> My question is whether P1022 audio driver cannot support full duplex?

I was never able to get the P1022ds audio to work in full duplex.  After 
trying for a few weeks, I just gave up.

If you look inside fsl_ssi.c (the main driver) you'll see this comment I 
wrote:

/*
  * FIXME: The documentation says that SxCCR[WL] should not be
  * modified while the SSI is enabled.  The only time this can
  * happen is if we're trying to do simultaneous playback and
  * capture in asynchronous mode.  Unfortunately, I have been enable
  * to get that to work at all on the P1022DS.  Therefore, we don't
  * bother to disable/enable the SSI when setting SxCCR[WL], because
  * the SSI will stop anyway.  Maybe one day, this will get fixed.
  */

(it should say "I have been unable" instead of "I have been enable")

Full duplex works fine on the MPC8610, which has the same audio 
controller as the P1022, so I know the controller is physically capable 
of it.  I just don't know why it doesn't work on the P1022DS.  I also 
don't know if it's a problem with the P1022DS board or with the P1022 
SOC itself.
