Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F5D91A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 21:12:34 +1000 (AEST)
Date: Tue, 2 Jun 2015 13:12:27 +0200
From: Thomas Huth <thuth@redhat.com>
To: Dinar Valeev <k0da@opensuse.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Dinar Valeev
 <dvaleev@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix function keys sequence on USB
Message-ID: <20150602131227.3054b8a3@thh440s>
In-Reply-To: <CADqALGRXOQnsd0x9pWfdnUphS+PafxAF-X3bNS9HVYdx4dP0qA@mail.gmail.com>
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
 <87iob6jvau.fsf@linux.vnet.ibm.com>
 <CADqALGSZ4-SLEjjLcjC+diw7P0TgctjaqtRtXDOUOPxmvtqVqQ@mail.gmail.com>
 <87fv6ajtd1.fsf@linux.vnet.ibm.com>
 <CADqALGRXOQnsd0x9pWfdnUphS+PafxAF-X3bNS9HVYdx4dP0qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2 Jun 2015 12:43:16 +0200
Dinar Valeev <k0da@opensuse.org> wrote:

> On Tue, Jun 2, 2015 at 12:29 PM, Nikunj A Dadhania
> <nikunj@linux.vnet.ibm.com> wrote:
> > Dinar Valeev <k0da@opensuse.org> writes:
> >
> >> On Tue, Jun 2, 2015 at 11:47 AM, Nikunj A Dadhania
> >> <nikunj@linux.vnet.ibm.com> wrote:
> >>> Dinar valeev <k0da@opensuse.org> writes:
...
> >>>> @@ -290,36 +286,34 @@ static void check_key_code(uint8_t *buf)
> >>>>                               case 0x49:
> >>>>                                       write_key(0x1b);               /* INS */
> >>>>                                       write_key(0x5b);
> >>>> -                                     write_key(0x31);
> >>>> +                                     write_key(0x32);
> >>>>                                       write_key(0x7e);
> >>>>                                       break;
> >>>>
> >>>>                               case 0x4a:
> >>>>                                       write_key(0x1b);              /* HOME */
> >>>>                                       write_key(0x5b);
> >>>> -                                     write_key(0x32);
> >>>> -                                     write_key(0x7e);
> >>>> +                                     write_key(0x48);
> >>>
> >>> Looking at accept.fs - handle-ESC-5b ...
> >>>
> >>> : handle-ESC-5b
> >>>    key
> >>>    dup 31 = IF \ HOME
> >>>       key drop ( drops closing 7e ) handle-^A
> >>>    ELSE
> >>>       dup 33 = IF \ DEL
> >>>          key drop handle-^D
> >>>       ELSE
> >>>          dup 34 = IF \ END
> >>>             key drop handle-^E
> >>>          ELSE
> >>>             dup 1f and handle-CSI
> >>>          THEN
> >>>       THEN
> >>>    THEN drop
> >>> ;
> >>>
> >>>
> >>> ... following change is sufficient:
> >>> -                                       write_key(0x32);
> >>> +                                       write_key(0x31);
> >>>
> >> Home sequence for me is: ^[[H
> >
> > Can you check the above change in your setup ?
> That works as well.

Not sure, but IIRC some of these key codes depend on the keyboard
layout that you are using. What keyboard layout (i.e. language) do
you use?

 Thomas
