Date: Sat, 8 Mar 2003 12:21:36 -0600
From: Nathan Ingersoll <ningerso@ruralcenter.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-ID: <20030308182135.GA31349@ruralcenter.org>
References: <20030307210257.7b094f55.billfink@mindspring.com> <200303072011.54069.hollis@austin.ibm.com> <20030308030440.39fcdc90.billfink@mindspring.com>
Mime-Version: 1.0
In-Reply-To: <20030308030440.39fcdc90.billfink@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 08, 2003 at 03:04:40AM -0500, Bill Fink wrote:
>
> There's also a practical consideration.  For example, in the xine case,
> the test for Altivec support is done in the xine library package, whereas
> the main() program is in a separate package, namely the xine UI, of which
> there are actually several available UIs.  Now if there was a getaux
> function similar to the getenv function, this would make matters a lot
> simpler.
>
> So while the current xine code may be somewhat ugly, it does work and
> is pretty easy to implement within a library.

One issue I saw with the xine code, is if it's in a library, you may want
to use sigaction to save the previous handler, since the app may set it's
own signal handler.

While somewhat ugly, it should be relatively OS independant, and it
could also be used in a callback type fashion for testing instruction
availability on a variety of platforms. The code I linked to in my
original post is an example of this. It could be called with
cpu_detect(mmx_test); on x86, cpu_detect(altivec_test); on ppc, or
cpu_detect(vis_test) on sparc, etc.

Thanks for all the ideas folks, looks like I'll have to consider the
different approaches, or use a combination.

--
------------------------------------------------------------------------
| Nathan Ingersoll           \\ Computer Systems & Network Coordinator |
| ningerso@ruralcenter.org    \\ http://www.ruralcenter.org            |
| http://ningerso.atmos.org/   \\ Minnesota Center for Rural Health    |
------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
