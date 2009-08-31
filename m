Return-Path: <paulus@bilbo.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19100.24755.889091.412993@cargo.ozlabs.ibm.com>
Date: Tue, 1 Sep 2009 09:45:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ben Gamsa <ben@somanetworks.com>
Subject: Re: time jumps forward/backwards
In-Reply-To: <4A9C465D.4010801@somanetworks.com>
References: <4A9C465D.4010801@somanetworks.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben Gamsa writes:

> It appears to be the case that when the time on the system is around the 
> epoch (1970), that time will occasionally jump forward and then backward 
> by about 17592 seconds.  When it jumps forward, it always jumps back a 
> few milliseconds later.  However, it's not always easy to catch these 
> occurrences.  The delta is more specifically about 17592186059 usec, 
> give or take a few 10s of microseconds (most of the time), despite the 
> fact that the user-level program I have that is testing it only checks 
> every 10 milliseconds.

I don't think the time code in the kernel is designed to handle
negative values, i.e., times before the epoch.  If you want it to do
that you'll have to check places like arch/powerpc/kernel/time.c,
kernel/time/timekeeping.c, arch/powerpc/include/asm/time.h, etc., and
make sure that it uses signed types where necessary and that the
arithmetic is correct.

Paul.
