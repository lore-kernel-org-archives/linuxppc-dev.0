Message-Id: <200008202108.XAA00678@piglet.grunz.lu>
Date: Sun, 20 Aug 2000 23:08:52 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: mmap for controlfb (was: Re: some stuff about controlfb in 2.2)
To: olh@suse.de
cc: linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org,
        geert@linux-m68k.org
In-Reply-To: <200008191942.VAA00720@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi again,

I have just verified that the patch I sent before does work on 2.2
kernels (2.2.16 kernel.org, that is, for me).

Have fun!

Michel

On  19 Aug, this message from mlan echoed through cyberspace:
> Hi all,
>
>>> I would like to attach the mentioned kernel patch to improve
>>> performance, have no idea yet how to benchmark it.
>
> Question here is how do we change the caching attributes for the
> framebuffer mmap in fbem.c, if we are running controlfb. This is the
> quick&dirty hack:
>
>>> diff -urN linux-2.2.16.SuSE.orig/drivers/video/fbmem.c linux-2.2.16.SuSE/drivers/video/fbmem.c
>>> --- linux-2.2.16.SuSE.orig/drivers/video/fbmem.c        Thu Aug 17 02:23:14 2000
>>> +++ linux-2.2.16.SuSE/drivers/video/fbmem.c     Fri Aug 18 11:04:46 2000
>>> @@ -577,7 +577,13 @@
>>>                 pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
>>>         }
>>>  #elif defined(__powerpc__)
>>> -       pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
>>> +       /* set mode for controlfb in PowerMacs
>>> +        * see http://www.cpu.lu/~mlan/linux/dev/xf4.html
>>> +        */
>>> +       if(find_devices("control"))
>>> +               pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
>>> +       else
>>> +               pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
>>>  #elif defined(__alpha__)
>>>         /* Caching is off in the I/O space quadrant by design.  */
>>>  #elif defined(__i386__)
>
>> I think the better way to handle this would be to provide a
>> device-specific mmap function in the framebuffers that benefit from the
>> changed caching. On Macs, all unaccelerated framebuffers should fall
>> under that category.
>
> So I went ahead and implemented mmap for controlfb. It's attached below
> in versions for both 2.2 and 2.4 kernels.
>
> I've not been able to test any of these, since all my recent kernels
> (both 2.2 and 2.4) refuse to boot. So, can all of those concerned please
> test this and let me know how it works out?

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
