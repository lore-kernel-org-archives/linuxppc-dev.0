From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 10:53:36 -0600
To: Matthew Locke <mlocke@mvista.com>
Cc: akuster <akuster@dslextreme.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
Message-ID: <20020725105336.F2276@host110.fsmlabs.com>
References: <3D3E4145.8030500@dslextreme.com> <3D3F04F7.1020005@mvista.com> <3D3F8EC9.7070105@dslextreme.com> <20020724233921.G5740@cort.fsmlabs.com> <3D402C79.5020808@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D402C79.5020808@mvista.com>; from mlocke@mvista.com on Thu, Jul 25, 2002 at 09:51:05AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I can only think of three ifdef's that would be necessary now but it could
grow.  If the #ifdef snarl is unattractive in idle.c it's easy enough to
move it to chipfamily-specific headers so that idle.c just needs to call
arch_idle() to enter an idle state.

The function pointer isn't desirable.  What the correct strategy for power
saving is known at compile time so there shouldn't be a function pointer
dereference.  How the #ifdef's are done doesn't really matter as long as
the inefficiency of a function pointer is avoided.

} I thought one of the linuxppc desgin goals was to keep the ifdefs to a
} minimum.  I can see idle.c growing quite large and full of #ifdefs if we
} do it that way.  Rather than using ppc_md, make power_save an
} abstraction similar to platform_init.
}
} >
} >
} >} This sounds like a good idea if we could use
} >}   if( ppc_md.powersave != NULL)
} >}        ppc_md.powersave();
} >}
} >} If it is determined that calling power_save() which is resides in an
} >} arch/processor specific file then we are talking about many files being
} >} hit.  and the current power_save seems to common for many other ppc
} >} platforms other than 4xx & 8xx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
