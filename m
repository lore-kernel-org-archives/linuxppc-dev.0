Message-ID: <3D402C79.5020808@mvista.com>
Date: Thu, 25 Jul 2002 09:51:05 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: cort@fsmlabs.com
Cc: akuster <akuster@dslextreme.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
References: <3D3E4145.8030500@dslextreme.com> <3D3F04F7.1020005@mvista.com> <3D3F8EC9.7070105@dslextreme.com> <20020724233921.G5740@cort.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


cort@fsmlabs.com wrote:

>There's need for the indirection for this sort of thing.  The only reason
>I created ppc_md was to allow for different machines to run off a single
>binary but not different chip families.
>
>A big #ifdef for the chip-type would work fine since the chip family is
>known at compile time.  The machine type isn't always know which is the
>reason for ppc_md.
>

I thought one of the linuxppc desgin goals was to keep the ifdefs to a
minimum.  I can see idle.c growing quite large and full of #ifdefs if we
do it that way.  Rather than using ppc_md, make power_save an
abstraction similar to platform_init.

>
>
>} This sounds like a good idea if we could use
>}   if( ppc_md.powersave != NULL)
>}        ppc_md.powersave();
>}
>} If it is determined that calling power_save() which is resides in an
>} arch/processor specific file then we are talking about many files being
>} hit.  and the current power_save seems to common for many other ppc
>} platforms other than 4xx & 8xx
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
