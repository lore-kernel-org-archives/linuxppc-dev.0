Message-ID: <406DBE90.1060603@gcctech.com>
Date: Fri, 02 Apr 2004 14:27:12 -0500
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: linas@austin.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: General question about caching
References: <406D92CF.8040302@gcctech.com> <20040402110239.A58706@forte.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I'll give it a shot.

1. Isn't it taking up memory?  If not then what does "Cached: 11924kB"
mean in meminfo?  With my embedded application, I desperately need every
byte I can get; 11924k is HUGE in my little 32MB environment.

2. Not sure why its vague that avoiding needless caching in ram of stuff
that's already in ram is silly.  Perhaps the performance hit is minimal,
but its still silly.  At the very least won't there be some needless
data copying?

Which cache is used for file contents?  That would be the one I don't need.

linas@austin.ibm.com wrote:

>On Fri, Apr 02, 2004 at 11:20:31AM -0500, Christopher R. Johnson wrote:
>
>>I have a tight footprint, and no swapping (in fact no disks).  I notice
>>that /proc/meminfo reports:
>>
>...
>
>>I only have rom and ram-based file systems, so I believe that disk
>>caching could and maybe should be reduced to use less space.  Can I
>>
>
>Why?  What's wrong with the way it is?  Is it impacting performance?
>Thrashing?  I can see a vague argument that its (nearly) pointless
>to cache buffers from ramdisk ... but it would take some work to flesh
>out this argument.
>
>That said, you can play with parameters in /proc/sys/vm although
>none of those directly affect the buffer cache size.  Indirectly,
>setting the flush times to zero might shrink the effective buffer
>cache, though... maybe. And it might hurt performance, maybe ...
>
>--linas
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
