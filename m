Message-ID: <3B643E84.3080004@hadess.net>
Date: Sun, 29 Jul 2001 17:49:08 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: userspace button controls
References: <20010724015531.516c9985.jpgarcia@execpc.com>	<3B63877E.9060001@hadess.net> <20010729010905.3faf9642.jpgarcia@execpc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Joseph P. Garcia wrote:

>Greetings.
>
>On Sun, 29 Jul 2001 04:48:14 +0100
>Bastien Nocera <hadess@hadess.net> wrote:
>
>>Well, the buttons_patch doesn't work on the ibook2:
>>
>[...]
>
>>eject: Unhandled button code 0b
>>
>
>Perfect!  This is what I was looking for.  Attached is a patch to make things work... maybe.  I don't know what to expect with the power key.  The eject key on the iBook2 is apparantly still an adb-button... neato.. i think.
>
>You will probably get an 'unknown scancode' for the eject key, but you can get the idea how to fix that from the patch.  change the cooresponding 0 to a KEY_EJECTCD, recompile, and it should work.  I don't know what exactly to expect from it.
>
>BTW, I contacted James Simmons, a developer in linuxconsole and framebuffer.  He mentioned that this sort of thing (fb-backlight, new input keys) are planned for 2.5.x.  Which makes sense, as volume/eject keys are no big diff at the moment, but, as Michael Schmitz pointed out, the backlight-related changes should not be introduced under the table.
>
>So volume keys and eject key (power too?) should be merge-able after completion and some testing.
>
Apparently the power key is already merged, as it shows up just fine in
evtest, the only problem (to make it handled by keyevd) is that it is on
another input device (ADB Keyboard instead of ADB Buttons). Moving it to
the ADB buttons would make it handlable.

With your patch (and the eject button added in the mac_hid.c table), the
eject button doesn't show up either in evtest or in keyevd. And the
brightness controls are of no effect, although the events are caught
correctly...

Cheers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
