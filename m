From: tom_gall@vnet.ibm.com
Message-ID: <3AD5F612.E3E282E8@vnet.ibm.com>
Date: Thu, 12 Apr 2001 18:38:10 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: compiler or kernel source defines
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

  Mike Corrigan one of the PPC 64 developers dropped by today with an
interesting set of questions that I think we need to give some thought to.

  Currently today there are places in the code (for /proc for example) where
there are some tests for the __powerpc__ define.

  This is a define that of course gcc defines and passes in for free.

  However the test for this particular code is really "are we powerpc32 or are
we powerpc64?", not are we on the powerpc architecture.

  One *COULD* again rely on gcc defines that you get for free to determine this
test at compile time, __PPC64__ as a recall, however is this the right thing to
do?

  Is there are larger design approach question, where we should NOT depend on
the defines that come for free from gcc but instead rely on say a CONFIG that
comes from the config.in that we can test again ... so CONFIG_PPC64/CONFIG_PPC32
or some such.

  Personally I feel safe using the gcc defines we get for free, and just
patching the set of device drivers or other offending code that is using
__powerppc__ when it really should be testing conceptually using:

#ifdef defined(__powerpc__) and !defined(__PPC64__)

32 bit PPC kernel code

#elif defined(__powerpc__) and defined(__PPC64__)

64 bit PPC kernel code

#endif

  Seems like the only risk here is that one always assumes to be using gcc and
that's perfectly valid to me.

  Opinions? Feedback?

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
