Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18067.22066.466767.663198@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 19:49:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
In-Reply-To: <je1wfgh9qj.fsf@sykes.suse.de>
References: <469270F3.4070206@austin.ibm.com> <46928691.2040008@austin.ibm.com>
	<18066.53384.449544.952545@cargo.ozlabs.ibm.com>
	<je1wfgh9qj.fsf@sykes.suse.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > Manish Ahuja writes:
> >
> >> Repost to fix my email id.
> >> 
> >> Fix to correct a possible infinite loop or an always true check when the 
> >> unsigned long counter "i" is used in
> >> lmb_add_region() in the following for loop:
> >> 
> >> for (i = rgn->cnt-1; i >= 0; i--)
> >
> > Unfortunately this won't fix the bug.  Since rgn->cnt is unsigned
> > long, the comparison will be done as an unsigned comparison even if i
> > is signed.
> 
> ??? There is no rgn->cnt involved in the comparison.

Look further down in lmb_add_region; there is a second for loop that
does

	for (i = rgn->cnt-1; i >= 0; i--)

I agree that Manish's patch description was misleading, but there is
a real problem in there.

Paul.
