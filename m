Message-Id: <5.1.0.14.2.20020612211908.02c7b0e8@mail.attbi.com>
Date: Wed, 12 Jun 2002 21:24:31 -0700
To: Dan Malek <dan@embeddededge.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: consistent_alloc from an interrupt context
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3D081A1A.70309@embeddededge.com>
References: <5.1.0.14.2.20020612200144.00ab2398@mail.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

At 09:05 PM 6/12/2002, you wrote:
Hmmmm.....Why did I think this was corrected in the past?  I see all of
>the consistent_alloc users are doing the same thing.  I know we discussed
>this, and the solution was actually quite trivial.  All we have to do is
>pass a GFP_ATOMIC into the kmalloc() (called by get_vm_area()).  IIRC,
>we added a 'gfp' parameter to get_vm_area() (and changed all callers, which
>was just a few), and then passed the 'gfp' into the kmalloc().  I know
>many of us tried it and everything worked sweetly :-)
>
>I thought the change was readily accepted by the generic code powers, I guess
>no one actually checked it in :-)  You could make the change locally and have
>a good day :-)  All you have to do is add the parameter to get_vm_area(),
>find all of the places it is currently called and add 'GFP_KERNEL' as the
>parameter.  In consistent_alloc(), just pass the 'gfp' variable.

I thought of it, but is it OK to modify arch-independent code with such a hack?

Maybe this is the reason it never was accepted.

Though, it's obviously much simpler than solution I used :)


  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
