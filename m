Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 932581A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 15:30:05 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E68D41401F6
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 15:30:04 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 24 Jun 2015 11:00:02 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 27FCFE0058
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 11:03:36 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5O5TubE6750480
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 10:59:57 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5O5TudD002487
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 10:59:56 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Thomas Huth <thuth@redhat.com>
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, dvaleev@suse.com
Subject: Re: [PATCH SLOF 4/5] disk-label: add support for booting from GPT FAT
 partition
In-Reply-To: <20150624021013.GE19845@gate.crashing.org>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1434959987-8530-5-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150623093444.18481f04@thh440s> <20150624021013.GE19845@gate.crashing.org>
Date: Wed, 24 Jun 2015 10:59:53 +0530
Message-ID: <87zj3p7jxq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Tue, Jun 23, 2015 at 09:34:44AM +0200, Thomas Huth wrote:
>> > +: load-from-gpt-partition ( [ addr ] -- size | TRUE )
>> 
>> What do you mean with addr in square brackets? Is it optional?
>
> And "size | TRUE"?  The code even returns "false" instead, which
> usually is a valid size (0).  Just always return a flag?  Or maybe
> you mean something like ( -- false | size true ) .  Not going to
> read the code, I cannot keep track of the stack, bringing us to...
>
>
>> Hmm, I wonder whether we need a proper coding conventions spec for
>> writing Forth code ... (at least about the indentation depths ...) ;-)
>
> "Write readable code.  That means in part, do not write long definitions
> (longer than a few lines)."

I ended up here by combining two similar looking words as they were
doing too many similar stuff.

But I guess it ended up being pretty big. I will break it up into
smaller units and resend this patch.

>
> There, all coding conventions you'll ever need :-)
>
>
> Almost all short definitions (with good names!) are easily readable
> (with a little effort if the subject matter is tricky).  No longer
> definitions are ever readable (well, there are exceptions; not many).
>
> Don't get hung up on "how many spaces should I indent"...  Since your
> words are short, you won't have more than two levels of indent anyway :-)
>
> Adding extra spacing to group things is also very helpful.
>
> Minor things...  Most words want a stack comment.  If you need stack
> comments inside a definition, it is too complex.  If there is any
> significant amount of stack juggling, the word is too complex.  If
> the word would be too complex, you need to factor it.  If you cannot
> easily split off factors, your solution is too complex.  If it is
> hard to think of good names for the factors, that is simply because
> naming things is the hardest part of programming (but see also the
> previous point).
>
> You also want short words that do one little thing because you _do_
> test your code.

Regards
Nikunj
