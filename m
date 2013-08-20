Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 8B81C2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 18:38:14 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 17878-10 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 20 Aug 2013 09:38:09 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: BUG_ON and gcc don't mix
Date: Tue, 20 Aug 2013 09:36:05 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72FF@saturn3.aculab.com>
In-Reply-To: <20130820044534.GD3430@bubble.grove.modra.org>
References: <20130820123750.7353f2f1@kryten>
 <20130820043211.GC3430@bubble.grove.modra.org>
 <20130820044534.GD3430@bubble.grove.modra.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Alan Modra" <amodra@gmail.com>,
	"Anton Blanchard" <anton@samba.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, wschmidt@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Tue, Aug 20, 2013 at 02:02:11PM +0930, Alan Modra wrote:
> > On Tue, Aug 20, 2013 at 12:37:50PM +1000, Anton Blanchard wrote:
> > > address of the trap instruction for our bug exception table. Maybe
> > > we need a gcc builtin in which we can get a label on the trap
> > > instruction. Would that be possible?
> >
> > Not your actual _EMIT_BUG_ENTRY, but something like this ought to =
work.
> > The only trick here is not putting anything after __builtin_trap()..
>
> Doh!  I guess the whole point was to get the condition folded into the
> trap, which is foiled by emitting an asm between the condition and
> buildin_trap().

I was thinking that you could add the label after the trap and
then use '.long 1b-4'. But you'd have to put the asm outside the
conditional - so that wouldn't work if the condition was more
complicated and the trap had to be out of line.

If the trap is out of line, then it could be a long way from
the surrounding code block - so a label 'nearby' in the C isn't
any use.

With fix sized instructions the .text segment of the object files
could be scanned for trap instructions.

	David
