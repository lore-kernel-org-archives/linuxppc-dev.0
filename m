From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15874.23846.177956.192840@argo.ozlabs.ibm.com>
Date: Fri, 20 Dec 2002 10:58:30 +1100
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: New style dpalloc/hostalloc routines (diff).
In-Reply-To: <3E006C94.2090503@intracom.gr>
References: <3E006C94.2090503@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou writes:

> +# Support new type of routines, usable from modules
> +bool 'Use new type dpalloc routines()' CONFIG_NEW_DPALLOC
> +bool 'Use new type hostalloc routines()' CONFIG_NEW_HOSTALLOC
> +if [ "$CONFIG_NEW_DPALLOC" = "y" -o "$CONFIG_NEW_HOSTALLOC" = "y" ]; then
> +  define_bool CONFIG_CPM_RHEAP y
> +fi

I don't want to see config options that select between different
internal implementations of the same thing.  Either your new routines
are better, and we'll use them, or they are worse, and we'll use the
old ones.  Having a config option just leads to tons of ifdefs
throughout the code, which makes it harder to read and understand.
Having two implementations of the same thing is just bloat.

Similarly, I don't like the way all your new routines have a "new_"
prefix on the name.  You should be thinking of replacing the existing
routines rather than providing an alternative implementation with a
different name.  Where you have changed the API, either fix the
drivers or provide a compatibility routine.

The way it looks at the moment, it seems that you don't really have
the conviction that your code is better than what is there already.
Please redo your patch so that it just replaces the old routines.  And
please don't send it as a bkpatch since they are impossible to read, a
plain diff -u is much better.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
