From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <jeffk@jdkoftinoff.com>, <linuxppc-dev@lists.linuxppc.org>,
	Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Having linking problems with atomic_inc(),
 atomic_dec_and_test() in user app, help!
Date: Fri, 4 Jan 2002 13:57:37 +0100
Message-Id: <20020104125737.19448@smtp.noos.fr>
In-Reply-To: <5.1.0.14.2.20020104064034.0218c160@falcon.si.com>
References: <5.1.0.14.2.20020104064034.0218c160@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>I have what I hope is an easy question for you... I have am writing an
>>user-space application that does some multithreading (using pthreads), and
>>does some thread-safe reference counting by using the functions in
>>asm/atomic.h.  Specifically, I'm using the atomic_inc(atomic_t *) and
>>atomic_dec_and_test(atomic_t *) functions.

Those are kernel functions, not availble to userland. If your userland
application need them, you have to either re-implement them, or rely on
equivalent routines provided by glibc if any.

If you plan to re-implement them, beware that some CPU-specific errata
have to be taken into account, you probably want to add all the sync's
that are CONFIG-dependant in the kernel in your userland implementation
for it to work properly on all PPC CPUs and on SMP machines.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
