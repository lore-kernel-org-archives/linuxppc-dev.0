Return-Path: <geoff@infradead.org>
Subject: Re: Kernel hang on PS3 with SMP
From: Geoff Levand <geoff@infradead.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <4EAA02A7.7010109@infradead.org>
References: <CAHsu+b-AEtOs+YuYxYFTkMjGwUMoc3jP9cYYkb31nZ+JVrGNVQ@mail.gmail.com>
 <1310808863.13765.3.camel@twins>  <4EAA02A7.7010109@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 28 Oct 2011 18:33:25 -0700
Message-ID: <1319852005.24935.40.camel@gum>
MIME-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frank.rowand@us.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, 2011-10-27 at 18:17 -0700, Geoff Levand wrote: 
> I verified that indeed 317f394160e9beb97d19a84c39b7e5eb3d7815a8
> 'sched: Move the second half of ttwu() to the remote cpu' introduces
> the hang.

After some more digging I found that it seems a short while after
startup ps3_smp_message_pass() gets called with a PPC_MSG_RESCHEDULE,
but then there is no corresponding call to scheduler_ipi() on the target
cpu.

I'll do some more work on it and verify that this is what is actually
happening.

-Geoff
