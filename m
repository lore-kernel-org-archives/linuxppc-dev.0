From: schinder@pobox.com
Date: Fri, 8 Oct 1999 09:30:25 -0400
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: What's up with gcc 2.95.1 and "__va_arg_type_violation"
Message-ID: <19991008093025.A3784@pobox.com>
References: <99100721144003.26148@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99100721144003.26148@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 07, 1999 at 09:08:16PM -0400, Kevin Hendricks wrote:
} 
} Hi,
} 
} When attempting to run the latest build of the jdk, I get the following error
} message (but only on non-debug builds).
} 
} Unsatisfied Link error: __va_arg_type_violation

If you turn off the optimizer, it will stop complaining.  I ran into this
building xemacs.

} 
} Figuring, I simply forgot some new piece of glibc 2.1.2, I used 
} 
} nm -o `find /lib -name "*"` | grep va_arg_type  
}  
} (for /lib, /usr/lib, /usr/local/lib, /opt/lib, etc)
} 
} and this damn routine simply does not exist on my machine.
} 
} Any ideas of where one might look to fulfill this thing.  This is new with
} gcc-2.95.1 and/or glibc 2.1.2
} 
} 
} By the way, native threads still do not work with the very latest glibc 2.1.2
} because of the new semaphore functions.  If I force linking to the old
} semaphore functions, everything starts working again.
} 
} I am building a debug glibc 2.1.2 and I will try to find the source of the
} problem.

Take a look at /usr/lib/ppc-redhat-linux/2.95.1/include/va-ppc.h.
It's in there.  I don't know why; I suspect it's part of an upcoming
fix of varargs.  The egcs that comes with Yellow Dog (and I assume
LinuxPPC) doesn't have this problem.

} 
}  Any ideas here would be greatly appreciated.
} 
} Thanks,
} 
} Kevin
} 

-- 
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
