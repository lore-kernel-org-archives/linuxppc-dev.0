Message-ID: <3FA668FA.6030803@kunk.jriver.com>
Date: Mon, 03 Nov 2003 08:40:58 -0600
From: "Robert E. Brose II" <bob@kunk.jriver.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: Robert E Brose II <bob@kunk.qbjnet.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQS on 6 Slot Macs
References: <20031103033529.24416.qmail@kunk.qbjnet.com> <1067859023.1653.15.camel@thor.asgaard.local>
In-Reply-To: <1067859023.1653.15.camel@thor.asgaard.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
> On Mon, 2003-11-03 at 04:35, Robert E Brose II wrote:
>
>>In trying to get OpenGL working on a YDL 3.0 system with kernel 2.4.22-ben2
>>and XFree86-4.3.0-2.1e,  I get a warning on X initialization:
>>
>>(II) R128(0): [drm] failure adding irq handler, there is a device already using
>>that irq
>
>
> Not sure what's up with that (depending on how old the DRM is, the error
> could be misleading though), but this shouldn't prevent the DRI from
> working.

The reason I was wondering about the IRQ is I've been trying to get 3d
stuff (like tuxracer) to run and I get the error message:


*** tuxracer error: Couldn't initialize video: X11 driver not configured
with OpenGL (Success)

Now the glxgears programs runs with about 400 fps (1024x768x24 400 mhz g3)

I can't run tuxracer compiled by me or the stock ydl3.0 one. Other 3d
stuff I compile fails as well with the same message. I'm pretty sure I
have the X and kernel configuration right. (similar settings work on an
  x86 box with a 3dfx card).

	Load    "GLcore"
         Load    "dbe"
         Load    "extmod"
         Load    "fbdevhw"
         Load    "dri"
         Load    "glx"
         Load    "record"
         Load    "freetype"
         Load    "type1"

And I'm building the kernel with 4.1 rage 128 drm support and the r128
module is loaded and there are no errors on X startup other than that
IRQ error (which is also noted in the dmesg when the r128 kernel module
loads)

also glxinfo looks ok to me so I'm having a hard time figuring out the
problem.

root# glxinfo

name of display: :0.0
display: :0  screen: 0
direct rendering: Yes
server glx vendor string: SGI
server glx version string: 1.2
server glx extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
client glx vendor string: SGI
client glx version string: 1.2
client glx extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
GLX extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
OpenGL vendor string: VA Linux Systems, Inc.
OpenGL renderer string: Mesa DRI Rage128 20020221 AGP 1x
OpenGL version string: 1.2 Mesa 4.0.4
OpenGL extensions:
     GL_ARB_imaging, GL_ARB_multitexture, GL_ARB_texture_env_add,
     GL_ARB_transpose_matrix, GL_EXT_abgr, GL_EXT_bgra, GL_EXT_blend_color,
     GL_EXT_blend_minmax, GL_EXT_blend_subtract, GL_EXT_clip_volume_hint,
     GL_EXT_convolution, GL_EXT_compiled_vertex_array, GL_EXT_histogram,
     GL_EXT_packed_pixels, GL_EXT_polygon_offset, GL_EXT_rescale_normal,
     GL_EXT_texture3D, GL_EXT_texture_env_add, GL_EXT_texture_object,
     GL_EXT_vertex_array, GL_IBM_rasterpos_clip, GL_MESA_window_pos,
     GL_NV_texgen_reflection, GL_SGI_color_matrix, GL_SGI_color_table
glu version: 1.3
glu extensions:
     GLU_EXT_nurbs_tessellator, GLU_EXT_object_space_tess

Any more suggestions are appreciated!

Thanks,
Bob


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
