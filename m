Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: can/should we use gcc 3.1 to compile kernels
Date: Fri, 7 Jun 2002 16:44:08 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <200206081337.31359.kevin.hendricks@sympatico.ca> <200206071544.56448.kevin.hendricks@sympatico.ca> <20020607201906.GP14252@opus.bloom.county>
In-Reply-To: <20020607201906.GP14252@opus.bloom.county>
MIME-Version: 1.0
Message-Id: <200206071644.08382.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,


#define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs-> ## REG).r))

Invoked via something like:

out_le32(CNTRL_REG(p,start_addr),
                 par->yoffset * par->pitch + (par->xoffset << par->cmode));

But control_regs looks like:

struct control_regs {
...
           struct preg start_addr; /* start address: 5 lsbs zero */
...
}

and preg looks like:

struct preg {                   /* padded register */
        unsigned r;
        char pad[12];
};

struct fb_info_control {
...
        struct control_regs     *control_regs;
...
}

So assuming p is a pointer to a fb_info_control_structure

then CNTL_REG(p,start_addr) must turn out to be:

(&((p->control_regs-> start_addr).r))

Is that correct?

It seems to need parentheses to me to help see what goes with what...

 It is funny to have a stucture given the exact same name as a field of
another structure, perhaps that is what is confusing gcc 3.1?  (and ME!)

Thanks,

Kevin


On June 7, 2002 04:19, Tom Rini wrote:
> On Fri, Jun 07, 2002 at 03:44:56PM -0400, Kevin B. Hendricks wrote:
> > Not too bad warnings-wize excpet for the controlfb.c where it
> > constanly gave a funny warning about "pasting ->".
>
> Sounds right.  I think there was a few other things too..
>
> > It did this for every occurence of the macro CNTRL_REG which I must
> > admit has two ## which I think gcc was misinterpreting somehow.
>
> Well, isn't:
> #define x(foo) a_## foo ##_b
> A semi-common thing, like we do in indirect_pci.c ?  Or was it something
> different?
>
> > Other than that just the occaissioanal wanring about unused variables
> > and things like that.
>
> Lots of the USB stuff uses __FUNCTION__ which gcc-3.1 isn't happy
> about.
>
> > I should have saved the build.log
>
> S'alright.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
