Message-Id: <200009211941.VAA05085@piglet.grunz.lu>
Date: Thu, 21 Sep 2000 21:40:58 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: CPU Temperature Patch
To: trini@kernel.crashing.org
cc: ad@mpifr-bonn.mpg.de, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000920110436.C15401@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  20 Sep, this message from Tom Rini echoed through cyberspace:
>
> On Wed, Sep 20, 2000 at 05:03:42PM +0200, Albrecht Dreß wrote:
>>
>> "D.J. Osguthorpe" wrote:
>> > Here are two patches that appear to fix the cpu_temp function in setup.c.
>> > They have been applied to a number of Ben Herrenschmidt kernels on a 500 MHz
>> > Pismo powerbook and print reasonable values when you cat /proc/cpuinfo.
>>
>> The patch seems to work on my Lombard/333, too... Really great!
>>
>> > +       /* this set for 500 MHz Pismo - how do we get access to clock?? */
>>
>> There is, in the same file, around line 319 code to read the clock speed from
>> the device tree. However, is it really necessary to include the clock speed at
>> this point? What is the drawback if we just assume 500 MHz (or even the max
>> value) for every G3 based machine?
>
> Why assume when we can do it properly?  Besides, a friend of mine oc'ed his
> B&W to 550, so it's possible to have >500Mhz :)

To do it properly on all machines requires a processor frequency
calculating routine, that doesn't depend on OF. Note that on all
upgraded machines that did not initially have a G3, OF's value is wrong
(too low, actually)!

On the other hand, Motorola's doc states that setting too large a value
doesn't hurt, so I guess we can safely hardcode something like 600 MHz.

At the only expense of busy-waiting a bit too long on slower machines...
but how often do you look at /proc/cpuinfo? Besides, you could always do
the aproximation using the interrupt ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
