From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: ian reinhart geiser <geiseri@msoe.edu>, linuxppc-dev@lists.linuxppc.org
Message-Id: <v03110701b53c67db3905@[129.100.29.243]>
In-Reply-To: 
 <Pine.LNX.4.10.10005080915420.8539-100000@opal.biophys.uni-duesseldorf.de>
References: <00050714365900.05361@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 8 May 2000 08:56:46 -0400
Subject: Re: Problems Compileing PVM
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>That's what I meant by 'sloppy programming'. Your instructions cover
>everything but one tiny detail: it is common practice to pass the 'args'
>va_list argument to other functions further down. In some cases I've seen,
>a pointer to the va_list argument is passed (which breaks on PPC). What's
>the proper coding style here?

In the jdk ppc code, we do exactly that.  In fact, a bunch of us argued
that the ppc vararg stuff was very broken because of this fact but the sysv
abi is the bible and no one with any power would change it.

I asked Franz about adding a macro to do this properly (just like the
va_start, va_end) but as it stands, there is no cross-platform way to pass
pointers to varargs.  So all code that does this will require a ppc ifdef.

Here is how we handle this case in the jdk source along with a code snippet
to illustrate its use.

If it were up to me I would add an official macro called va_ptr or something:

/* fix for varargs differences */
#if defined(__powerpc__)
#define VARGS(x) (x)
#else
#define VARGS(x) (&x)
#endif

static ResultType JNICALL
jni_CallVoidMethodV(JNIEnv *env, jobject obj,
                          jmethodID methodID, va_list args) {
    ResultType result;
    result = jni_Invoke(env, obj, methodID,
                        jni_PushArgumentsVararg, VARGS(args),
                        INVOKE_VIRTUAL | retType).unionType;
    return result;
}

Kevin

--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
