From: "Todd_Tomaino"@vnci.net
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256A18.005DD98E.00@ushq1.vnci.net>
Date: Fri, 23 Mar 2001 12:29:17 -0500
Subject: Re: NTSC Video on the 823
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>Where did you find these files?

ftp://ftp.mvista.com/pub/Area51/embedded-planet/video.tgz



Matthel Locke wrote:
>>chuck's code is based on a different i2c driver than the one in
>>8xx_io.   Unless Todd has the i2c driver developed by EP, it probably
>>won't work

The "patchVideo" file contains an I2c driver.  I did not load it, assuming
that the more recent version I currently use would be preferable and
compatible.  I will try recompiling with the "patch Video" version and see
if there is any change.


>>>Where is this "Open error -19" coming from?  There is lots more
>>>code executed than your little snippet shows.

It could be from this code segment located in Vid823.c, I'm not sure what
this indicates.

/* open or close a file in kernel space... */
struct file *drvfopen(const char * filename, int flags, int mode)
{
    struct file *f;
    int error;

    f = filp_open(filename, flags, mode);
    error = PTR_ERR(f);
    if (IS_ERR(f))
    {
========>    printk("Open error %d\n",error);
        return 0;
    }
    return f;



thanks for the help!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
